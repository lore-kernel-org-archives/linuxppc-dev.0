To: Andreas Plaickner <apxx@gmx.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 3Com 574BT PCMCIA Card on PowerPC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 31 Jan 2003 13:04:38 +0100."
             <2651.1044014678@www39.gmx.net>
Date: Fri, 31 Jan 2003 21:16:21 +0100
Message-Id: <20030131201626.51061C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <2651.1044014678@www39.gmx.net> you wrote:
>
> I have seen that there exists already a solution
> for a wireless LAN card. I took these steps as

Which one are you talking about? Where did you get the kernel sources
and the PCMCIA CS package from?

> ## Booting image at 40040000 ...
>    Image Name:   Linux-2.4.4
>    Created:      2002-07-17  10:40:49 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)

Looks suspiciously like one of "our" source trees. But  this  version
is  much  too  old  for  WLAN support; this was added / fixed several
months later.

> I didn't create a new kernel, but I used one that was already
> pre-installed on the board. Could this one be the reason
> for the above error?

Definitely. You will need a current kernel,  and  currend  PCMCIA  CS
package.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Niklaus Wirth has lamented that, whereas Europeans pronounce his name
correctly  (Ni-klows  Virt),  Americans  invariably  mangle  it  into
(Nick-les  Worth).  Which  is to say that Europeans call him by name,
but Americans call him by value.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
