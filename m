Subject: Re: MPX8xx: MMC over SPI....
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Wolfgang Denk <wd@denx.de>
Cc: Kate Alhola <kate@iti.fi>,
	David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040309235955.BC6B7C0655@atlas.denx.de>
References: <20040309235955.BC6B7C0655@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1078907569.16004.9.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Wed, 10 Mar 2004 09:32:49 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I agree in this with Wolfgang, I have had very bad experiences
with SPI as inter processor communication channel in the past.
And then you are in the luxury position of having 'intelligence'
(processors) on both sides which can detect and clean up the
CPM's SPI mess.

Jaap-Jan

On Wed, 2004-03-10 at 00:59, Wolfgang Denk wrote:
>
> I don't know your exact application,  but  it  always  gives  me  the
> creeps when I read the phrases "mass storage device" and "SPI bus" in
> the same sentence. I tend to summarize this as follows:
> "mass storage device"  + "SPI bus" = need for redesign :-)
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> By the way, ALL software projects are done by iterative  prototyping.
> Some companies call their prototypes "releases", that's all.
>

____
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
