Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B61E5B6F75
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 05:41:53 +1100 (EST)
Message-ID: <4ED7CA64.2080503@freescale.com>
Date: Thu, 1 Dec 2011 12:41:40 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] i2c-mpc: use the cell-index property to enumerate the
 I2C adapters
References: <1322760781-31226-1-git-send-email-timur@freescale.com>
In-Reply-To: <1322760781-31226-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2011 11:33 AM, Timur Tabi wrote:
> An I2C device tree node can contain a 'cell-index' property that can be
> used to enumerate the I2C devices.  If such a property exists, use it
> to specify the I2C adapter number.

Didn't we decide a long time ago that this was a bad idea?

> This feature is necessary for the Freescale PowerPC audio drivers (e.g.
> on the P1022DS).  The "machine driver" needs to know the adapter number
> for each I2C adapter, but it only has access to the device tree.
> Previously, the I2C nodes always appeared in cell-index order, so the
> dynamic numbering coincided with the cell-index property.  With commit
> ab827d97 ("powerpc/85xx: Rework P1022DS device tree"), the I2C nodes are
> unintentionally reversed in the device tree, and so the machine driver
> guesses the wrong I2C adapter number.

What specifically do you need this number for?  What does it represent?

-Scott
