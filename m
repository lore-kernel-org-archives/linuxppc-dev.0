From: benh@kernel.crashing.org
To: Alain RICHARD <alain.richard@equation.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Support for new Dual G4 1 Gig machines?
Date: Wed, 30 Jan 2002 15:55:30 +0100
Message-Id: <20020130145530.1118@mailhost.mipsys.com>
In-Reply-To: <F83E36A3-1565-11D6-8E33-0030657D0D7C@equation.fr>
References: <F83E36A3-1565-11D6-8E33-0030657D0D7C@equation.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Just for information, why do you consider sungem better than gmac ? What
>kind of functionnalities is it supposed to better handle than gmac ?

no copy, better perfs (after the latest tuning we did), better management
of link (including fallback to forced speeds if autoneg fails, ...), support
for ethtool ioctls, better power management (especially the chip isn't shut
down immediately on ifconfig down, but only after about 10 seconds which means
a dhcp client will work better).

>Also about the video cards, there is two options :
>
>- ATI Radeon 7500 (32 Mo)
>- NVIDIA GeForce4 MX (64 Mo of RAM)
>
>Is there any clue about the support of each one ?

ATI will probably work properly with 2D accel, end eventually DRI soon,
while nVidia will be problematic since they don't provide us with specs
nor drivers.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
