Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id C849167B2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 08:11:12 +1000 (EST)
Message-ID: <42A0D714.1050601@mvista.com>
Date: Fri, 03 Jun 2005 15:17:56 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <42A0CD46.60300@mvista.com>
	<20050603214653.GA15314@gate.ebshome.net>
In-Reply-To: <20050603214653.GA15314@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] Add support for Maxim/Dallas DS1374 Real-Time Clock
 Chip
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
[snip]
> 
> I wonder, why you chose to use those 1-byte SMBus transfers instead of 
> i2c transfer.

I was simply following the guidelines in 
Documentation/i2c/writing-clients as noted in the driver header. This 
note was in the driver I used as my base, so I just followed along.

> 
> I wrote similar DS1374 driver some time ago which used those transfers 
> and they worked just fine.

I checked http://secure.netroedge.com/~lm78/supported.html, 
http://secure.netroedge.com/~lm78/newdrivers.html and looked in the 
lm_sensors-2.9.1 tarball before I started and didn't see a driver for 
the DS1374 listed. That's why I threw mine together. Maybe I missed it.

I would have used I2C transfers myself, but was simply following what I 
thought were current practices. Since this is my first I2C client, I 
just blindly followed the documentation :) Oh well, wouldn't be the 
first time I wandered down the wrong path.

		Randy Vinson
