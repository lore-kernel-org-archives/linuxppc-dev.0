Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 00FCCDE124
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 09:56:16 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1993936nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 15:56:15 -0700 (PDT)
Date: Thu, 27 Mar 2008 01:56:11 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/5] i2c: MPC837xRDB Power Management and GPIO expander
	driver
Message-ID: <20080326225611.GA2799@zarina>
References: <20080326202511.GD1772@localhost.localdomain>
	<47EAB885.7000006@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47EAB885.7000006@freescale.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 03:56:37PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > +config MCU_MPC837XRDB
> > +	tristate "MPC837XRDB MCU driver"
> > +	depends on I2C && MPC837x_RDB && OF_GPIO
> 
> The MPC8349E-mITX also has this chip.  Can you include support for that board as
> well?

Well, only if it has the same (or compatible) firmware.. then yes.

Thanks for the info, I'll look into this.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
