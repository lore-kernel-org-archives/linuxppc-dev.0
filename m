Date: Sat, 31 Jul 1999 15:57:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ethan Benson <erbenson@alaska.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Open Firmware booting on a Blue G3
In-Reply-To: <v04210106b3c7ff057f2a@[192.168.0.1]>
Message-ID: <Pine.LNX.4.10.9907311531450.420-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 30 Jul 1999, Ethan Benson wrote:
>   puetzk6715@uni.edu mentioned that OF has filesystem support, so quik 
> would not be needed and OF could be configured to boot the kernel 
> directly.  I responded that this approach would require a separate 
> ISO, HFS, HFS+, or FAT filesystem either in a /boot partition or the 
> entire root partition would have to be formatted in those formats.  I 
> mentioned that I do not like the idea of having to maintain non ext2 
> filesystems to support my kernel. I also mentioned the following 
> arguments for retaining and improving quik:

I have a FAT /boot partition on my CHRP box for this purpose.

> At 16:16 -0800 28/7/99, Ethan Benson wrote:
> >well one reason that would be good to have quik around is quik makes 
> >setting up kernel images much easier then mucking around in OF 
> >(something people seem to have a problem with given all the 
> >slobbering over BootX) and quik could be given the same security and 
> >password controls that LILO has, with OF being totally unprotectable 
> >it is difficult to prevent someone from booting linux into single 
> >user mode, if the only way to enter single user mode was by passing 
> >'single' at the quik prompt then quik can be set to ask a passwd 
> >when arguments are given (just like restricted lilo)

Decent OF implementations allow to set a password.

The question arise whether even the latest Apple implementations of OF are
decent. Do they have a decent `see' implementation these days?
I could completely reverse engineer my OF by using `see', if I'd want to...

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
