Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D05CF2C04FF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:41:13 +1000 (EST)
Message-ID: <51947F7E.8040104@windriver.com>
Date: Thu, 16 May 2013 14:41:02 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SATA FSL and upstreaming
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B1E0442@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368685428.9603.41.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C409@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368686221.9603.48.camel@pasglop>
In-Reply-To: <1368686221.9603.48.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>,
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

On 05/16/2013 02:37 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-16 at 06:33 +0000, Bhushan Bharat-R65777 wrote:
>> protect off 0xec000000 +$filesize; erase 0xec000000 +$filesize; cp.b
>> 0x1000000 0xec000000 $filesize
>
> BTW, is it normal that the network in uboot is *extremely* unreliable ?

We can use serial port:

loadb   - load binary file over serial line (kermit mode)
loads   - load S-Record file over serial line
loady   - load binary file over serial line (ymodem mode)

Then please send the RCW with appropriate mode above in your terminal client.

Tiejun
