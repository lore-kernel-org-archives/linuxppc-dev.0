Message-ID: <40D734CE.9090502@gmx.de>
Date: Mon, 21 Jun 2004 21:19:42 +0200
From: Mark Jonas <mark.jonas@gmx.de>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working
References: <42A622EB18325843894BB8E1040E3DF5022753@sinaexchf>
In-Reply-To: <42A622EB18325843894BB8E1040E3DF5022753@sinaexchf>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Iñigo,

I experienced this behavior with an USB card before. With that card the
reason was a short on the USB card between 3.3V and 5V supply pins. In a
normal PC this seems to be no problem (maybe because a PC's PCI ports
are 5V only). The Lite5200 survived. To be sure if this is the problem I
recommend testing the card for the short.

Mark

>Hi.
>I've bought a 3.3V PCI ethernet card (US Robotics 7900) and tried to use it with the Lite5200 kit, but when I power it, it doesn't even turn on, with both power LEDs (3.3V and 5V) off. What may be the problem and where should I look for it?
>Thanks.
>
>Iñigo
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
