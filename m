Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD48BDE24B
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 03:17:53 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7LHB12s002743
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 13:11:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7LHHi42166820
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 11:17:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7LHHhSe025658
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 11:17:44 -0600
Date: Thu, 21 Aug 2008 13:17:12 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [RFC][PATCH] I2C driver
Message-ID: <20080821131712.5254a13e@zod.rchland.ibm.com>
In-Reply-To: <48ADA090.8020100@harris.com>
References: <48AD9610.8090205@harris.com>
	<1219336202.26429.55.camel@jdub.homelinux.org>
	<48ADA090.8020100@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 21 Aug 2008 13:06:24 -0400
"Steven A. Falco" <sfalco@harris.com> wrote:

> Josh Boyer wrote:
> > On Thu, 2008-08-21 at 12:21 -0400, Steven A. Falco wrote:
> >> The following patch enables building the I2C driver for 4xx chips.
> >> Tested on a Sequoia board.  Comments invited.
> >>
> >> Signed-off-by: Steven A. Falco <sfalco@harris.com>
> >> ---
> >>  drivers/i2c/busses/Kconfig      |    7 +++++++
> >>  drivers/i2c/busses/i2c-ibm_of.c |    5 ++---
> >>  2 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > That file doesn't even exist in the mainline kernel:
> > 
> > [jwboyer@yoda linux-2.6]$ find drivers/i2c/ -name *ibm*
> > drivers/i2c/busses/i2c-ibm_iic.c
> > drivers/i2c/busses/i2c-ibm_iic.h
> > [jwboyer@yoda linux-2.6]$ 
> > 
> > josh
> > 
> > 
> 
> Interesting.  Ok - I found the problem with the driver you *did* find:

.26 doesn't have what can be considered awesome i2c support.  But the
latest git trees are much better.  See git commits:

d3dc685eb5ef64aa695dabb74f00440ec3ab6796
and
b1204e6ec16468ebf89d9d818bfe425ca7adcdf3

They deal with the problems you highlighted with the listing and index
stuff.  There might be more issues outstanding, but using the latest
kernel is going to get you better support and prevent you from finding
problems that are already fixed :)

josh
