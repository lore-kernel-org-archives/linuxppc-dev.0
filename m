To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RAMDISK IMAGES: why no ethernet in my image ... but denx ok 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 12 Jan 2003 13:08:17 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC06033@SNCMAIL>
Date: Sun, 12 Jan 2003 21:18:28 +0100
Message-Id: <20030112201833.74C8BC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DB0585C9F6F9D411BE8F00D0B7896A4CC06033@SNCMAIL> you wrote:
>
> I just managed to create my first ram-disk image. Which seems to work more
> or less ... however my Ethernet doesn't seem to get configured with my ram
> disk image (see out put below) ...

This does NOT depend on the ramdisk image. It  is  either  a  problem
with  your  kernel  configuration (CONFIG_IP_PNP not set), and/or the
kernel boot arguments you pass to it.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
       There is enough for the need of everyone in this world,
       but not for the greed of everyone.     - Mahatma Gandhi

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
