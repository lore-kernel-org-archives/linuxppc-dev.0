Return-Path: <danielwa@cisco.com>
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rls5b0lQ8zDr2j
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 08:01:22 +1000 (AEST)
Subject: Re: t1040 IFC flash driver Extended Chip Select
To: Scott Wood <scott.wood@nxp.com>, Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Jaiprakash Singh <b44839@freescale.com>, Scott Wood
 <scottwood@freescale.com>, Lijun Pan <Lijun.Pan@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>
References: <577D68B8.8020305@cisco.com>
 <DB5PR0401MB1928C329F9B0FF9AAF5A607B913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577E79D4.1010709@cisco.com>
 <DB5PR0401MB1928CD680EFFD3A1712AA9F6913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EB10B.7010601@cisco.com>
 <DB5PR0401MB1928FF35ABE36D8E07BAA079913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EC0FC.8020304@cisco.com>
 <DB5PR0401MB1928FBF1769BCE0DE0E3E503913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577ECE6C.3000100@cisco.com>
 <DB5PR0401MB192848637D543D8B95B6092D913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <577ED12C.30105@cisco.com>
Date: Thu, 7 Jul 2016 15:01:16 -0700
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB192848637D543D8B95B6092D913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2016 02:59 PM, Scott Wood wrote:
> On 07/07/2016 04:49 PM, Daniel Walker wrote:
>> On 07/07/2016 02:23 PM, Scott Wood wrote:
>>> I suspect that add the usage of cspr_ext into the driver would fix the
>>> issue we have. It reads like you would find that acceptable ?
>>> What specifically is the problem you're having?  Is it that CSPR_EXT is
>>> not getting written to, and thus the device does not appear at the
>>> address that it should?
>>>
>>> Or is the driver matching incorrectly?  The only way the driver's lack
>>> of using CSPR_EXT to match would be a problem would be if you have
>>> multiple chipselects with the same address in the lower 32 bits, and
>>> only CSPR_EXT distinguishing them.  Since you proposed a device tree
>>> binding that assumes all devices have the same CSPR_EXT, I doubt that's
>>> the case, so I doubt adding CSPR_EXT matching to the driver will solve
>>> your problem.
>>>
>>> -Scott
>>>
>> I didn't do the debug on this. From my perspective it's either flash
>> works, or it doesn't work. We need the code below for it to work,
> Adding CSPR_EXT matching to the driver will not accomplish the same
> thing as that code.
>

So from u-boot perspective, the values in the device tree under "ranges" 
or parts of it, are place into the cspr and cspr_ext ? Is that how it's 
suppose to work ?

Daniel
