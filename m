Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 09:22:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-ID: <20071106222243.GB31367@localhost.localdomain>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<9e4733910711052025m7905efb6ja3e4b6a022e6aa81@mail.gmail.com>
	<20071106154004.4f01a536.sfr@canb.auug.org.au>
	<9e4733910711061102w710f670ey48a0cca72883084@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9e4733910711061102w710f670ey48a0cca72883084@mail.gmail.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 06, 2007 at 02:02:12PM -0500, Jon Smirl wrote:
> Second pass at extending i2c core to accept strings of aliases for
> the
[snip]

> -/* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi>.
> +/* With some changes from KyÃ¶sti MÃ€lkki <kmalkki@cc.hut.fi>.

This looks like an unrelated change of character encoding has slipped
in here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
