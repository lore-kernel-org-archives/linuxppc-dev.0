Message-ID: <3B8B63AA.BA34DF7F@us.ibm.com>
Date: Tue, 28 Aug 2001 09:26:02 +0000
From: Scott Carroll <scottcar@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Power3: LAST_PKMAP' undeclared here (not in a function)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-- gcc -D__KERNEL__ -I/usr/src/latest_0828b/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-Wa,-mppc64bridge    -c -o highmem.o highmem.c
highmem.c:33: `LAST_PKMAP' undeclared here (not in a function)
highmem.c: In function `flush_all_zero_pkmaps':
highmem.c:47: `LAST_PKMAP' undeclared (first use in this function)
highmem.c:47: (Each undeclared identifier is reported only once
highmem.c:47: for each function it appears in.)
highmem.c: In function `map_new_virtual':
highmem.c:85: `LAST_PKMAP' undeclared (first use in this function)
highmem.c:88: `LAST_PKMAP_MASK' undeclared (first use in this function)
highmem.c:119: warning: implicit declaration of function `PKMAP_ADDR'
highmem.c:120: `kmap_prot' undeclared (first use in this function)
highmem.c: In function `kmap_high':
highmem.c:142: warning: implicit declaration of function `PKMAP_NR'
highmem.c: At top level:
highmem.c:274: syntax error before `int'
highmem.c:302: warning: type defaults to `int' in declaration of
`__initcall'
highmem.c:302: warning: parameter names (without types) in function
declaration
highmem.c:302: warning: data definition has no type or storage class
highmem.c:33: warning: `pkmap_count' defined but not used
make[2]: *** [highmem.o] Error 1
make[2]: Leaving directory `/usr/src/latest_0828b/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/latest_0828b/mm'
make: *** [_dir_mm] Error 2m
Scott Carroll                           IBM RS/6000
Division
11400 Burnet Road, M.S. 9541   Notes:   scottcar@us.ibm.com
Austin, TX  78758-3493 U.S.A   phone:   +1 (512) 838-9642

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
