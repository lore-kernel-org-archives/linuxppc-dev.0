Message-ID: <015a01c2a85d$33273e70$6401a8c0@pats>
From: "pat_etc" <pats@embeddedtoolsmiths.com>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
References: <20021220180907.AB1EAC6139@atlas.denx.de>
Subject: Re: use bdi on board with ppcbug 
Date: Fri, 20 Dec 2002 14:22:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


to see where your boot code starts:

at the BDI prompt the command:
reset halt  <enter>
followed by the command
info  <enter>

BDI responds with:

    Target state      : debug mode
    Debug entry cause : debug port nonm
    maskable breakpoint
   Current PC        : 0xfff00100

current pc is where your boot code starts
hope this helps
pat

----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
Sent: Friday, December 20, 2002 1:09 PM
Subject: Re: use bdi on board with ppcbug


> In message <3E03565A.49119F4@synergymicro.com> you wrote:
> >
> > Wouldn't it be the PowerPC reset address - 0xFFF00100?
>
> 0xFFF00100 is just one out of several possibilities, depending on CPU
> type and system configuration.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
