Date: Thu, 25 Jul 2002 10:29:49 -0700
From: Matt Porter <porter@cox.net>
To: steve.cameron@hp.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Tigon3 driver, broadcom 5307, 440GP, working?
Message-ID: <20020725102949.A24858@home.com>
References: <20020724132923.A31993@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020724132923.A31993@zuul.cca.cpqcorp.net>; from scameron@zuul.cca.cpqcorp.net on Wed, Jul 24, 2002 at 01:29:23PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 24, 2002 at 01:29:23PM -0500, Stephen Cameron wrote:
>
> I've been playing around with the tigon3 driver and a broadcom
> 5307 gigabit NIC in my IBM ebony... No luck so far.  The driver compiles
> and even loads, I can run ifconfig(busybox really) to configure
> the NIC,  and if I pull the network cable, the driver seems to
> notice (get log messages about link is down, link is up) but so
> far, I can't actually transmit or receive any packets.
>
> Anyone had any luck with this combination?

I assume you mean a BCM5703?

FWIW, BCM5700/5701 on 440GP works for me with the current tg3 driver.


Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
