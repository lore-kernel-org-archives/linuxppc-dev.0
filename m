Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6066DDE4C9
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:04:13 +1000 (EST)
Message-ID: <48BFF8E4.9070400@freescale.com>
Date: Thu, 04 Sep 2008 10:04:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v4 1/2] powerpc: Board support for GE Fanuc SBC610
References: <20080901102753.8068.36706.stgit@ubuntu8041.localdomain>	<20080901102758.8068.77414.stgit@ubuntu8041.localdomain>	<20080902182709.GB16741@ld0162-tx32.am.freescale.net>
	<20080904155127.5ca8fca3.martyn.welch@gefanuc.com>
In-Reply-To: <20080904155127.5ca8fca3.martyn.welch@gefanuc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Martyn Welch wrote:
> On Tue, 2 Sep 2008 13:27:09 -0500
> Scott Wood <scottwood@freescale.com> wrote:
> 
>> On Mon, Sep 01, 2008 at 11:27:59AM +0100, Martyn Welch wrote:
>>> +static __initdata struct of_device_id of_bus_ids[] = {
>>> +	{ .compatible = "simple-bus", },
>>> +	{ .type = "serial", },
>>> +	{ .type = "soc", },
>>> +	{ .type = "i2c", },
>> i2c and serial don't belong here, and soc is redundant with simple-bus.
>>
> 
> I agree about the i2c and serial, although I need the soc entry for the i2c devices to be found during the platform scan.

Not if the soc node has simple-bus in its compatible, which I thought I 
remembered yours did.

-Scott
