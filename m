Message-Id: <20010423055600.Postino-004748@smtp01.highway.ne.jp>
Date: Mon, 23 Apr 2001 05:56:00 +0900
To: linuxppc-dev@lists.linuxppc.org
Cc: cort@fsmlabs.com
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: problems in kernel 2.4.4pre6 bk tree
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

i got this problem in today's kernel.

Any help

Kaoru
----------
gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/linux/include -Wall -Wstrict-prototypes -
O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -
pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -DEXPORT_SYMTAB -
c rwsem.c
rwsem.c:14: warning: `RWSEM_WAITING_FOR_READ' redefined
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:26: warning: this is the location
of the previous definition
rwsem.c:15: warning: `RWSEM_WAITING_FOR_WRITE' redefined
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:27: warning: this is the location
of the previous definition
In file included from rwsem.c:6:
/usr/src/redhat/BUILD/linux/include/linux/rwsem.h:52: parse error before `(
'
/usr/src/redhat/BUILD/linux/include/linux/rwsem.h:53: parse error before `(
'
/usr/src/redhat/BUILD/linux/include/linux/rwsem.h:54: parse error before `(
'
In file included from /usr/src/redhat/BUILD/linux/include/linux/rwsem.h:60,
                 from rwsem.c:6:
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:25: parse error before `wait
_queue_head_t'
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:25: warning: no semicolon at
end of struct or union
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h: In function `init_rwsem':
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:79: dereferencing pointer to
incomplete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:80: warning: implicit declaration
of function `init_waitqueue_head'
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:80: dereferencing pointer to
incomplete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h: In function `__down_read':
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:96: dereferencing pointer to
incomplete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h: In function `__down_write':
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:110: dereferencing pointer
to incomplete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h: In function `__up_read':
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:125: dereferencing pointer
to incomplete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h: In function `__up_write':
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:137: dereferencing pointer
to incomplete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h: In function `rwsem_atomic_
update':
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:147: dereferencing pointer
to incomplete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h: In function `rwsem_cmpxchgw
':
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:167: dereferencing pointer
to incomplete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:168: dereferencing pointer
to in
complete type
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:168: dereferencing pointer
to in
complete type
In file included from /usr/src/redhat/BUILD/linux/include/linux/fs.h:12,
                 from /usr/src/redhat/BUILD/linux/include/linux/capability.h:
17,
                 from /usr/src/redhat/BUILD/linux/include/linux/binfmts.h:5,
                 from /usr/src/redhat/BUILD/linux/include/linux/sched.h:9,
                 from rwsem.c:7:
/usr/src/redhat/BUILD/linux/include/linux/wait.h: At top level:
/usr/src/redhat/BUILD/linux/include/linux/wait.h:151: warning: `init_waitqueue
_h
ead' was declared implicitly `extern' and later `static'
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:80: warning: previous declaratio
n of `init_waitqueue_head'
/usr/src/redhat/BUILD/linux/include/linux/wait.h:151: warning: type mismatch
wit
h previous implicit declaration
/usr/src/redhat/BUILD/linux/include/asm/rwsem.h:80: warning: previous implicit
d
eclaration of `init_waitqueue_head'
/usr/src/redhat/BUILD/linux/include/linux/wait.h:151: warning: `init_waitqueue
_h
ead' was previously implicitly declared to return `int'
In file included from rwsem.c:7:
/usr/src/redhat/BUILD/linux/include/linux/sched.h:211: field `mmap_sem' has
inco
mplete type
rwsem.c: In function `__rwsem_do_wake':
rwsem.c:55: dereferencing pointer to incomplete type
rwsem.c:57: warning: implicit declaration of function `__builtin_expect'
rwsem.c:97: dereferencing pointer to incomplete type
rwsem.c:106: dereferencing pointer to incomplete type
rwsem.c:107: dereferencing pointer to incomplete type
rwsem.c:107: dereferencing pointer to incomplete type
rwsem.c: In function `rwsem_down_read_failed':
rwsem.c:134: dereferencing pointer to incomplete type
rwsem.c:136: dereferencing pointer to incomplete type
rwsem.c:137: dereferencing pointer to incomplete type
rwsem.c: In function `rwsem_down_write_failed':
rwsem.c:182: dereferencing pointer to incomplete type
rwsem.c:184: dereferencing pointer to incomplete type
rwsem.c:185: dereferencing pointer to incomplete type
rwsem.c: In function `rwsem_wake':
rwsem.c:219: dereferencing pointer to incomplete type
make[2]: *** [rwsem.o] Error 1
make[2]: Leaving directory `/usr/src/redhat/BUILD/linux/lib'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/linux/lib'
make: *** [_dir_lib] Error 2
Bad exit status from /var/tmp/rpm-tmp.42865 (%build)
[root@g4mpKFUKUI SPECS]#


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
