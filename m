Message-ID: <38843E9C.E0EED65C@apus.co.at>
Date: Tue, 18 Jan 2000 11:21:16 +0100
From: "René Pachernegg" <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross-compiling sysvinit
References: <3884359F.C191BB70@apus.co.at>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Fixed it already. Thought I already tried everything. The prob was that
I set a link to the libs in the comiler/$target/lib dir. The linker
doesnt seem to like that. But copying the libs fixed it.

Regards
	René

René Pachernegg wrote:
> 
> Finally building the cross-compiler and the glibc succeded.
> Thanks to all the people from this mailing list who helped.
> 
> Actually I am trying to cross-compile sysvinit without succes.
> The linker /powerpc-linux/ld tells me :
> 
> cannot opten crt1.o: File or Directory not found
> 
> I found crt1.o in my cross-compiled glibc in /lib and passed
> the directory with the -L option to the Linker. Additionally I added
> this directory to PATH. --> No changes
> 
> Ann suggestions?
> 
> Regards
>         Rene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
