Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 9F57BDF3F9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 06:37:14 +1000 (EST)
Message-ID: <48ADD1F7.8060306@harris.com>
Date: Thu, 21 Aug 2008 16:37:11 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [RFC][PATCH] I2C driver
References: <48AD9610.8090205@harris.com> <48ADA090.8020100@harris.com>
	<20080821132731.47a2f49a@lappy.seanm.ca>
	<200808212105.29963.sr@denx.de>
In-Reply-To: <200808212105.29963.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Thursday 21 August 2008, Sean MacLennan wrote:
>> On Thu, 21 Aug 2008 13:06:24 -0400
>>
>> "Steven A. Falco" <sfalco@harris.com> wrote:
>>> However, while the i2c-ibm_of.c driver works with the sequoia .dts,
>>> i2c-ibm_iic.c does not, because it is looking for an "index" property,
>>> which is not in the .dts file.  I added one:
>> I don't know where i2c-ibm_of.c came from....
> 
> It's a temporary DENX version for arch/powerpc which we created, since it took 
> too long to get something accepted upstream (I remember endless discussions 
> about index properties...). And we needed something functional quite a while 
> ago.
> 
>> but in the 2.6.26 kernel 
>> you need the index property.
>>
>> The 2.6.27 kernel has a fully OF aware i2c-ibm_iic driver. You do
>> not need the index. And it will walk the device tree and setup the
>> devices for you.
> 
> Yes. Since 2.6.27 the "original" IBM I2C driver should be enough. We will drop 
> our local special version soon.
> 
> Best regards,
> Stefan
> 
> =====================================================================
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
> =====================================================================
> 

I was able to cherry-pick the i2c-ibm_iic driver from .27 into .26, so
I withdraw my comments regarding the soon-to-be-discarded i2c-ibm_of
driver.

	Steve
