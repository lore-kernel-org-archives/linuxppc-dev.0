Date: Tue, 7 Mar 2000 14:01:13 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb in Paul's 2.3.48
Message-ID: <20000307140113.A13319@drow.res.cmu.edu>
References: <200003071840.TAA03827@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200003071840.TAA03827@piglet.grunz.lu>; from mlan@cpu.lu on Tue, Mar 07, 2000 at 07:40:58PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 07, 2000 at 07:40:58PM +0100, Michel Lanners wrote:
> Hi list,
>
> I'm struggling with kernel 2.3 to get all my special stuff working
> again...
>
> Anyway, while experimenting, I noticed that the 2.3.48 controlfb
> doesn't recognize my 4 MB VRAM anymore. Here's the message:
>
>  controlfb: Memory bank 1 present, bank 2 absent, total VRAM 2MB
>
> Sure enough, both banks are present and do work in 2.2.13 (my current
> kernel).

Ark!  I could swear this was all taken care of.

Could you please send me (privately) a diff -u of the 2.2.13 and 2.3.48
controlfb?  I can't think offhand of any reasons for changes unless
someone has been mucking with the fbdev API when I wasn't looking.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
