To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Probelm for linux booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 May 2002 08:45:06 +0800."
             <001301c20060$cb3bf5c0$7301a8c0@zhongqx>
Date: Tue, 21 May 2002 08:24:13 +0200
Message-Id: <20020521062418.DAB461196D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001301c20060$cb3bf5c0$7301a8c0@zhongqx> you wrote:
>
>      I have FADS860T board,I want to use ppcboot-1.1.5 to boot linux 2.2.4 kernel.
> ppcboot-1.1.5 is ok,but when i use bootm command,
> it uncompressed ok and load ramdisk image then nothing happend,  can you meet this
> problem before? can you give me some advise? Should I need to change configure file
> of FADS860_defconfig ? Console is SMC1 and baudrate is 115200 bps.

Probably you are just wasting your  time  on  broken  hardware.  FADS
boards  (especially  the  older  ones  like  yours)  are not the most
reliable type of hardware.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as we know, our computer has never had an undetected error.
		                                           -- Weisert

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
