From: Konstantinos Margaritis <kmargar@cc.uoa.gr>
To: linuxppc-dev@lists.linuxppc.org
Subject: cvs kernel does not compile
Date: Wed, 12 May 1999 17:08:23 +0300
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99051217114000.00658@proton>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   The 2.3.0 kernel found on cvs.on.openprojects.net does not compile on
my powerpc system (debian glibc 2.1, egcs 1.1.2pre), with the following
error: 

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c ksyms.c
/usr/src/linux/include/linux/fs.h: In function `mark_buffer_clean':
In file included from /usr/src/linux/include/linux/capability.h:13,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:8,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,                                    from /usr/src/linux/include/linux/malloc.h:4,
                 from ksyms.c:13:
/usr/src/linux/include/linux/fs.h:763: warning: implicit declaration of function
 `test_and_clear_bit'
/usr/src/linux/include/linux/fs.h: In function `mark_buffer_dirty':
/usr/src/linux/include/linux/fs.h:771: warning: implicit declaration of function
 `test_and_set_bit'
ksyms.c: At top level:
ksyms.c:361: `init_special_inode' undeclared here (not in a function)
ksyms.c:361: initializer element for `__ksymtab_init_special_inode.value' is not
 constant

It's the first time it does this. Any ideas?

--
Konstantinos Margaritis

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
