Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <A3E34B558F5CD211B4980008C7A4A99003C5853B@sparrow.gso.mcs.marconi.com>
From: "Williams, Kevin M." <kevin.m.williams@marconi.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Abatron BDI2000 
Date: Tue, 20 Nov 2001 13:04:51 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think the register definition file (reg8xx.def) is the same, but there
seems to be more to the .cnf file than just architecture and board used.
That is covered in the [INIT] section.  I have that correct or I would not
have been able to debug my bootrom using gdb, read/write memory, etc.  I can
do all that without any problem, and if all I wanted was to debug the
bootrom I would be all set.

What I am having trouble with is getting it to download the compressed
kernel image.

Specifically, I was hoping to see what was in the [TARGET], [FLASH], and
[HOST] sections of a correct .cnf file for debugging the kernel. I must
either have an offset incorrect, or not have something enabled, or something
similar. That seems to be where my problem is....in that dozen or so lines
at the end of the cnf file.

I know this is a newbie question, and I have read the manual and made
several attempts but cannot get it to work, so I was trying to make the
inconvenience as small as possible by just asking to see someone's .cnf file
and I will figure out my mistake from there.

Thanks for any help.

Kevin

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Tuesday, November 20, 2001 12:13 PM
To: Williams, Kevin M.
Cc: linuxppc-embedded
Subject: Re: Abatron BDI2000



Dear Kevin,

in message
<A3E34B558F5CD211B4980008C7A4A99003C5853A@sparrow.gso.mcs.marconi.com> you
wrote:
>
> I just received a BDI2000 and it works great for debugging my bootrom, but
> I'm a little confused about settings to use for debugging the
> kernel...seeing a working example should be enough to get me going.

Oops??? The config file for the  BDI2000  depends  on  the  processor
architecture  and  board  used,  but  that's it. You can use the SAME
config file both for firmware and for Linux kernel debugging.

Make sure you've RTFM about the "MMU XLAT" and the "PTBASE" settings.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Computers are not intelligent.  They only think they are.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
