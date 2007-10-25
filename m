Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id CCE0BDDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 01:24:03 +1000 (EST)
Message-ID: <4720B4FA.5050106@semihalf.com>
Date: Thu, 25 Oct 2007 17:23:38 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 05/11] [POWERPC] TQM5200 DTS
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>	<20071023231333.29359.35252.stgit@hekate.izotz.org>
	<20071024015115.GK10595@localhost.localdomain>
In-Reply-To: <20071024015115.GK10595@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Oct 24, 2007 at 01:13:33AM +0200, Marian Balakowicz wrote:
> 
> [snip]
>> +	lpb@fc000000 {
>> +		model = "fsl,lpb";
>> +		compatible = "lpb";
> 
> Not nearly specific enough.  Must include a vendor prefix at least,
> and should have a lot more revision information.  You should always be
> able to pick the right driver with compatible alone, "model" should
> generally be for human consumption, the driver shouldn't need it.
> 
>> +		device_type = "lpb";
> 
> Drop this.  Again, presence of a device_type property is the
> exception, not the rule.
> 
>> +		ranges = <0 fc000000 02000000>;
> 
> You need #address-cells and #size-cells properties, too.
> 
> [snip]

OK, will update that. I guess I'll also need to use 'compatible' and
skip type when passing bus ids to of_platform_bus_probe().

m.
