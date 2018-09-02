#!/bin/bash
[ `who | wc -l` -ge 3 ] && echo 有人入侵 | mail -s "有人入侵" student
