Return-Path: <jdl@freescale.com>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071203015018.GC26919@localhost.localdomain>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
	<20071203015018.GC26919@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1196709993.7735.3.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 03 Dec 2007 13:26:34 -0600
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-12-02 at 19:50, David Gibson wrote:

> > +		clock-frequency = <7f28155>;		/* 133.333333 MHz */
> You can use <d# 133333333> to avoid the ugly hex.

Better still, blaze a new trail, convert it to /dts-v1/ and
use clock-frequency = <133333333> straight up!


jdl
