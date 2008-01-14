Return-Path: <scottwood@freescale.com>
Date: Mon, 14 Jan 2008 13:04:08 -0600
From: Scott Wood <scottwood@freescale.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: I2C and CAN bus on MPC5200B device tree
Message-ID: <20080114190408.GA3880@loki.buserror.net>
References: <478A967E.7080201@genesi-usa.com>
	<fa686aa40801131635o499c8c08i6a2667cd7df1a72e@mail.gmail.com>
	<20080114044216.GA23349@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080114044216.GA23349@lixom.net>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 13, 2008 at 10:42:16PM -0600, Olof Johansson wrote:
> I think simple devices might have been agreed upon (but it's been a
> while since it was covered). Muxed busses probably hasn't. Either that
> or I completely missed the emails.

I posted something in one of the i2c device tree threads a while ago:
http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036353.html

Basically, you just have a node that is both an i2c device and an i2c
controller, and the mux driver binds to it and registers the subordinate
buses as new i2c controllers.

-Scott
