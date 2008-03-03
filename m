Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11D5EDDF31
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 06:14:43 +1100 (EST)
Date: Mon, 3 Mar 2008 13:09:25 -0600
From: Scott Wood <scottwood@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2 v2] [POWERPC] Ignore disabled serial ports
Message-ID: <20080303190925.GA6735@loki.buserror.net>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301081746.689a0a17@zod.rchland.ibm.com>
	<200803030443.43346.arnd@arndb.de>
	<20080302224317.15f259ca@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080302224317.15f259ca@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 02, 2008 at 10:43:17PM -0600, Josh Boyer wrote:
> On Mon, 3 Mar 2008 04:43:42 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> > I wonder whether we should move the check for "used-by-rtas" into the
> > of_device_is_available function. I understand that used-by-rtas is
> > another way of expressing the idea that the kernel is not supposed to
> > access the specific device. In this case, the device is physically
> > present, but is not available to the OS.
> 
> I'd rather not at the moment.  My intention was to only look at the
> status property for now.  I'd like to avoid this function growing into
> a huge switch statement for $random_firmware's way of flagging
> something as "don't touch".

Better that than having the "huge" list of tests in every driver...

-Scott
