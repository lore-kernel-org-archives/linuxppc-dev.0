To: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 21 Jun 2004 12:03:23 +0200."
             <42A622EB18325843894BB8E1040E3DF5022753@sinaexchf>
Date: Mon, 21 Jun 2004 12:51:36 +0200
Message-Id: <20040621105141.8BA21C13D3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <42A622EB18325843894BB8E1040E3DF5022753@sinaexchf> you wrote:
>
> I've bought a 3.3V PCI ethernet card (US Robotics 7900) and tried to use it with the Lite5200 kit, but when I power it, it doesn't even turn on, with both power LEDs (3.3V and 5V) off. What may be the problem and where should I look for it?

You may have plugged it in incorrectly.  Make  sure  that  the  front
bezel  is on the side where the serial and USB connectors are - i. e.
NOT where the ATA connector is.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The human race is a race of cowards; and I am not  only  marching  in
that procession but carrying a banner.                   - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
