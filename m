Message-ID: <20030712233922.61094.qmail@web10009.mail.yahoo.com>
Date: Sat, 12 Jul 2003 16:39:22 -0700 (PDT)
From: john duc <jjtduc@yahoo.com>
Subject: Cannot compile u-boot under Mandrake 9.1
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I tried to compile u-boot-0.4.0 on Mandrake 9.1, but
not successful. Could someone help me fix this
problem.

Here what I did:

make distclean
make MPC8260ADS_config
make all

The error is:

gcc -Wall -pedantic -O -I/opt/powerpc/include  -o
astest astest.o error.o -L/opt/powerpc/lib -lbfd
-liberty
/usr//bin/ld: cannot find -lbfd
collect2: ld returned 1 exit status
make[2]: *** [astest] Error 1


Some libraries probably missing?

Thanks,

john


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
