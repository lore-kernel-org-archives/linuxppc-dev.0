From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: PPC405GP w/Linux?
Date: Thu, 3 Apr 2003 10:02:50 -0800
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C4868@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A couple of questions regarding building linux for PPC405GP, below.

> From: ext Wolfgang Denk [mailto:wd@denx.de]
> Subject: Re: ppc linux kernel 2.4.4 for ppc440/EBony using ELDK 2.0.2?
>
> The 2.4.4 LInux kernel as included in this version of the ELDK is not
> suitable for 4xx systems. Please use  the  linuxppc_2_4_devel  kernel
> tree instead; see http://penguinppc.org/dev/kernel.shtml

Is there anyway to FTP this kernel without having to use BitKeeper or
rsync (ie, they're blocked by firewall)?  I've got 2.4.18 with PPC
relevant patches - is that sufficient?

I've been unable to find any files that support the PPC405GP ethernet
driver (the MAL stuff).  Does this support exist, and if so what is the
file that implements it?  I see that there is a config file in 2.4.18
for the Walnut boards, so I assume there must be onboard ethernet support
somewhere (or is this only supported by add-on PCI boards?).

Darin Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
