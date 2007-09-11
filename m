Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18151.2530.439805.386163@cargo.ozlabs.ibm.com>
Date: Wed, 12 Sep 2007 07:34:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] Add 6xx-style HID0_SLEEP support.
In-Reply-To: <20070905220640.GB11353@ld0162-tx32.am.freescale.net>
References: <20070905220438.GA11283@ld0162-tx32.am.freescale.net>
	<20070905220640.GB11353@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> +_GLOBAL(mpc6xx_enter_sleep)

The name is slightly unfortunate as powerbooks also use 6xx-family
processors but enter sleep in a quite different manner, because they
exit sleep with a reset.  Can you think of a better name, that gives a
hint that this is the one to use if we are exiting sleep with an
interrupt rather than a reset?

Paul.
