Message-ID: <3EA826C0.8050509@mvista.com>
Date: Thu, 24 Apr 2003 11:02:40 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot/simple in ROM?
References: <5.1.0.14.2.20030424134156.036e1e80@falcon.si.com>
In-Reply-To: <5.1.0.14.2.20030424134156.036e1e80@falcon.si.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:

>
> The "simple" boot loaders are loaders, they are NOT bootroms.  They
> expect
> the board to have a firmware/bootrom/monitor that does the necessary very
> low level very hardware specific initialization (things like setting up
> memory maps, initializing the SDRAM controller, etc.).  The "simple" boot
> loaders do the added steps necessary for starting linux, so they are
> necessary but NOT sufficient.

In general this is true.  However, it is possible to put enough hw init
in the simple boot loader (bootwrapper as I and others now call it) to
run linux.  This has been done in the past.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
