Message-ID: <3AC9B2DC.1567BC90@netfall.com>
Date: Tue, 03 Apr 2001 04:24:12 -0700
From: Andrew Sharp <andy@netfall.com>
MIME-Version: 1.0
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: debian-powerpc@lists.debian.org, stewart.sadler@roke.co.uk,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: External Monitor under Pismo
References: <87vgonhx7p.fsf@amadeus.openinformatics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does your laptop have a key sequence that will switch the output
from LCD to CRT(external monitor) and back?  Mine does.  Fn-F8.
It's directly tied to the hardware and doesn't need any support in X
or Linux.  Of course it's an x86 laptop, but it's the same video
controller, so maybe your Pismo has something similar?  I have to
hit it a couple-o' three times to get it to switch, and it does a
three way deal: LCD, external, and both simultaneously.

a


"Jason E. Stewart" wrote:
>
> Hey All,
>
> So after 7 months of flailing I finally got my Pismo to run it's
> external monitor port, yeah!!!
>
> 3 days before I had a talk to give about our OpenSource project, I
> realized I was going to be using OpenOffice under linux, and I
> couldn't actually drive a projector... So after I got done panicing I
> hit google. I find a link on the YDL lists about the 'mirror' program
> that appears to have been originally written by Paul Mackeras.
>
> It gives me the functionality I need, but unfortunately it doesn't
> seem to work with 2.4 kernels, only 2.2. The program is doing some
> pretty low-level memory mojo which I am clueless about.
>
> Could someone slightly wiser point out what would change between 2.2
> and 2.4 that would cause this to break? Is it the base memory offset
> for the framebuffer?
>
> Cheers!
> jas.
>
>   --------------------------------------------------------------------
>                 Name: mirror2.c
>    mirror2.c    Type: text/x-csrc
>             Encoding: quoted-printable
>
>   --------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
