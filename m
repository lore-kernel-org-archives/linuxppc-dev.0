Message-ID: <3884359F.C191BB70@apus.co.at>
Date: Tue, 18 Jan 2000 10:42:55 +0100
From: "Reni Pachernegg" <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Cross-compiling sysvinit
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Finally building the cross-compiler and the glibc succeded.
Thanks to all the people from this mailing list who helped.

Actually I am trying to cross-compile sysvinit without succes.
The linker /powerpc-linux/ld tells me :

cannot opten crt1.o: File or Directory not found

I found crt1.o in my cross-compiled glibc in /lib and passed
the directory with the -L option to the Linker. Additionally I added
this directory to PATH. --> No changes

Ann suggestions?

Regards 
        Rene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
