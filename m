Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E1C72C0121
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:25:18 +1000 (EST)
Message-ID: <51947BC3.9040208@windriver.com>
Date: Thu, 16 May 2013 14:25:07 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: SATA FSL and upstreaming
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38 <51947A00.9010504@windriver.com>
 <3E027F8168735B46AC006B1D0C7BB0020B1E0461@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB0020B1E0461@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Liu Qiang-B32616 <B32616@freescale.com>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2013 02:20 PM, Zang Roy-R61911 wrote:
>
>
>> -----Original Message-----
>> From: tiejun.chen [mailto:tiejun.chen@windriver.com]
>> Sent: Thursday, May 16, 2013 2:18 PM
>> To: Benjamin Herrenschmidt
>> Cc: Zang Roy-R61911; Liu Qiang-B32616; Fleming Andy-AFLEMING; linuxppc-
>> dev@lists.ozlabs.org; Xie Shaohui-B21989; Bhushan Bharat-R65777
>> Subject: Re: SATA FSL and upstreaming
>>
>> On 05/16/2013 02:09 PM, Benjamin Herrenschmidt wrote:
>>> On Thu, 2013-05-16 at 06:05 +0000, Zang Roy-R61911 wrote:
>>>> I do not suggest changing the RCW. If the RCW is broken on Ben's
>>>> side, it is not easy to recover for him.
>>>> Let's check the U-boot output first.
>>>
>>> U-Boot 2013.01-00009-g7bcd7f4 (Mar 14 2013 - 14:23:16)
>>>
>>> CPU0:  P5020E, Version: 1.0, (0x82280010)
>>> Core:  E5500, Version: 1.0, (0x80240010) Clock Configuration:
>>>          CPU0:2000 MHz, CPU1:2000 MHz,
>>>          CCB:800  MHz,
>>>          DDR:666.667 MHz (1333.333 MT/s data rate) (Asynchronous),
>> LBC:100  MHz
>>>          FMAN1: 600 MHz
>>>          QMAN:  400 MHz
>>>          PME:   400 MHz
>>> L1:    D-cache 32 kB enabled
>>>          I-cache 32 kB enabled
>>> Board: P5020DS, Sys ID: 0x1c, Sys Ver: 0x12, FPGA Ver: 0x05, vBank: 0
>>> Reset Configuration Word (RCW):
>>>          00000000: 0c540000 00000000 1e120000 00000000
>>>          00000010: d8984a01 03002000 de800000 41000000
>>>          00000020: 00000000 00000000 00000000 10070000
>>>          00000030: 00000000 00000000 00000000 00000000
>>
>> I think you can use Bharat's RCW, which seems RR_HXAPNSP_0x36, then
>> please take a look at this:
> Why?

I just believe Bharat should pick a proper RCW from SDK.

> Ben's on board RCW protocol is 0x36, which should work for PCIe1 (slot 7) and PCIe3 (slot4).

Didn't you see I'm also saying to use slot 7 and slot 4?

Tiejun
