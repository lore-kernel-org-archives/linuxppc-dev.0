To: Liu Fred-a18596 <fred.liu@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: unable to input in u-boot at Lite5200 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 11 Mar 2004 20:38:57 +0800."
             <89DEFCC5DB33D411A27F00508BCF8A821489FCB7@ZCH07EXM05.corp.mot.com>
Date: Thu, 11 Mar 2004 16:59:42 +0100
Message-Id: <20040311155947.6E05AC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <89DEFCC5DB33D411A27F00508BCF8A821489FCB7@ZCH07EXM05.corp.mot.com> you wrote:
>
> I have burned u-boot.1.0.0 into Lite5200 board (icecube, 16M Flash, 64M SDRAM).
> u-boot printed fllowing information when I pushed the reset button.
...
> All information seems good, but I can't input key to stop autoboot.
> It seems  that it dont't accept any input from console.
> I don't know why this happened.
> Can anyone explain it?

Disable hardware flow control in your terminal emulation.

Please read the manual. See
http://www.denx.de/twiki/bin/view/DULG/SystemSetup#Section_4.3.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is not best to swap horses while crossing the river.
- Abraham Lincoln

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
