Date: 5 Jun 2002 09:18:36 -0000
Message-ID: <20020605091836.24714.qmail@webmail9.rediffmail.com>
MIME-Version: 1.0
From: "vandana  mehtani" <vandana_mehtani123@rediffmail.com>
Reply-To: "vandana  mehtani" <vandana_mehtani123@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Sukesh.Acharya@siritech.com
Subject: problem when compiling gcc for pwerpc
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all
i am trying to make a crosscompiler for powerpc using the option
powerpc-linux...
when i was trying to configure gcc for powerpc with the following
command
usr/src/gcc/gcc-2.96-20000731/configure --target=ppc-linux
--prefix=/ccpowerpc --enable-shared --enable-languages=c 2>&1 |
tee configure.out
i got the following error...

make[2] ppc-linux-ar
command not found..
make[2] [libgcc.a]
make[1] [stmp-multilib]Error 2
all-gcc
how do i rectify the error..
thanks in advance
vandana


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
