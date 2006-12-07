Return-Path: <Marta.Chamorro@xerox.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Power management for ppc 85xx
Date: Thu, 7 Dec 2006 19:57:23 -0000
Message-ID: <BFEE19E1D0DBF84698D76276388DCB843F22D2@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <99A19F8F-62E6-4D3D-A34B-3D815C7ED0C4@kernel.crashing.org>
From: "Chamorro, Marta" <Marta.Chamorro@xerox.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi again, Kumar,

You said on your first reply that it was easy to get the core to nap, so
that sounds like a suitable first step for me.

Any pointers? Is there, for instance, any ppc implementation of power
management I could look at to see how's done?

Thanks,

Marta


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: 06 December 2006 21:51
To: Chamorro, Marta
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: Re: Power management for ppc 85xx


On Dec 6, 2006, at 3:06 PM, Chamorro, Marta wrote:

> Hi there!
>
>
>
> Hope someone out there can give me some pointers here. I've got a =20
> 2.6.18 kernel on a ppc 8555, which I configured to enable power =20
> management (CONFIG_PM=3Dy). After doing that, the file /sys/power/=20
> state appears on my file system. If I cat the file I get "standby =20
> mem" (without the quotes), but if I try to write to it (to change =20
> the state) I get an EPERM. I assume it is because I have no code =20
> that implements any power save mode changes, only the interface to =20
> change them. Am I wrong? How can I tell for sure? (the file is =20
> writable, so it is not a problem with writing permissions)
I can pretty much say that there isn't any code that does pwr mgmt =20
for 85xx.  I'm not sure what exactly your issue is, but there =20
definitely isn't any code.
> So the question is (if I am right) where do I get the code from? I =20
> am hoping someone has implemented power save for that processor =20
> already, but I just don't know where to start looking for that =20
> code. Can someone help?
Getting the core to nap is easy enough, doing proper power savings =20
for the full SoC maybe more challenging.

What exact behavior are you looking for?  Something like suspend/=20
resume or just idle power savings?

- k
