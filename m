Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC2C3DE81B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 04:05:46 +1100 (EST)
Date: Tue, 18 Mar 2008 12:05:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2] Make 83xx perfmon support selectable
Message-ID: <20080318170542.GA4099@loki.buserror.net>
References: <1204934343-5235-1-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204934343-5235-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 05:59:03PM -0600, Andy Fleming wrote:
> Not all e300 cores support the performance monitors, and the ones
> that don't will be confused by the mf/mtpmr instructions.  This
> allows the support to be optional, so the 8349 can turn it off
> while the 8379 can turn it on.  Sadly, those aren't config options,
> so it will be left to the defconfigs and the users to make that
> determination.

So does this mean we can't do multiplatform of something with perfmon and
something without perfmon?  Seems like this should come from the device
tree, or PVR, or some other runtime check.

-Scott
