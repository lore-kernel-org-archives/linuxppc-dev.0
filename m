To: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Can not see any infomation on the console when using U-Boot 1.0.0 booting my board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 06 Dec 2003 18:32:20 +0800."
             <200312061024.EAA19753@lists.linuxppc.org>
Date: Sat, 06 Dec 2003 16:54:57 +0100
Message-Id: <20031206155502.A27C8C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200312061024.EAA19753@lists.linuxppc.org> you wrote:
>
> My reference board is Sandpoint X2.
...
> and Sandpoint X2 was booted smoothly.
>    Then I modified the serial port information in
> ~~/u-boot1.0.0/include/configs/sandpoint8240.h because the serial port

You should rather create your own board config file.

> address on my board is different from that on Sandpoint X2. Below are my
> modification:
...
>  	After "make" and "burn u-boot.bin in flash" I reset my board
> and I saw nothing on my console:(
> 	Any suggestion? Thanks in advance.

Well, what do you expect? Remote debugging through a telepathy link?

Obviously your changes are wrong and/or insufficient to  make  U-Boot
work on your baord.

Attach your BDI2000, fire up GDB and check what's going on there.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Name one thing windows is better than unix in?
                                          Making money for Microsoft?
         -- Randal L. Schwartz in <8cvi5t4c3t.fsf@gadget.cscaper.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
