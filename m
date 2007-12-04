Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4B21DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 00:14:43 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lB4DEdL2004191
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 06:14:39 -0700 (MST)
Message-ID: <475552BE.1030407@freescale.com>
Date: Tue, 04 Dec 2007 07:14:38 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
	<20071203015018.GC26919@localhost.localdomain>
	<1196709993.7735.3.camel@ld0161-tx32>
	<20071204003354.GB32577@localhost.localdomain>
In-Reply-To: <20071204003354.GB32577@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Dec 03, 2007 at 01:26:34PM -0600, Jon Loeliger wrote:
>> On Sun, 2007-12-02 at 19:50, David Gibson wrote:
>>
>>>> +		clock-frequency = <7f28155>;		/* 133.333333 MHz */
>>> You can use <d# 133333333> to avoid the ugly hex.
>> Better still, blaze a new trail, convert it to /dts-v1/ and
>> use clock-frequency = <133333333> straight up!
> 
> Hrm.. probably best to wait for dtc to go into the kernel for that.
> 

I disagree.

jdl
