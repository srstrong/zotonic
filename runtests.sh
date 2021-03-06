#!/bin/sh
#
# Copyright 2010 Arjan Scherpenisse
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
cd `dirname $0`

case "$1" in
erlydtl)
    # Test only erlydtl
    MODULES=`ls ebin/erly*tests.beam|sed 's/.beam//'|sed 's/ebin\///'`
    echo $MODULES
    ALL=""
    for MODULE in $MODULES; do ALL="-s $MODULE run_tests $ALL"; done
    exec erl erl -noshell -pa $PWD/ebin $PWD/deps/*/ebin -s erlydtl_tests_init init $ALL -s init stop
;;
*)
    # Find all tests
    MODULES=`ls ebin/*_tests.beam|sed 's/.beam//'|sed 's/ebin\///'|grep -v pgsql|grep -v erlydtl`
    ALL="zotonic"

    # Run the tests
    for MODULE in $MODULES; do ALL="$ALL,$MODULE"; done
    ALL=`echo $ALL|sed 's/^,//'`

    #exec erl -noshell -pa ebin -eval "eunit:test([$ALL],[verbose]),init:stop()"

    echo $ALL
    exec erl erl +P 10000000 +K true -pa $PWD/ebin $PWD/deps/*/ebin -boot start_sasl -sasl errlog_type error -s zotonic -eval "eunit:test([$ALL],[verbose]),init:stop()"
;;
esac

