Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 137AA68A8A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 06:48:25 +1100 (EST)
Date: Wed, 25 Jan 2006 11:48:23 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to read
	little-endian?
Message-ID: <20060125194823.GA19460@gate.ebshome.net>
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu> <200601251057.47619.sr@denx.de>
	<43D7C2EF.5060508@ovro.caltech.edu>
	<20060125185131.GA7425@gate.ebshome.net>
	<43D7D334.3070709@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43D7D334.3070709@ovro.caltech.edu>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 11:36:20AM -0800, David Hawkins wrote:

[snip]

> I haven't looked for it yet, but do you know if there is a driver
> for the Yosemite board I2C temperature sensor already written?

I have no idea what temp sensor is used in this board, but it's very 
likely that lm-sensors project already has a driver for it (look 
under Drivers/Hardware Monitoring support).

-- 
Eugene
