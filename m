Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0210B2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 15:56:02 +1000 (EST)
Message-ID: <519474E4.9030705@windriver.com>
Date: Thu, 16 May 2013 13:55:48 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SATA FSL and upstreaming
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
In-Reply-To: <1368683156.9603.34.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Qiang Liu <qiang.liu@freescale.com>, Andy Fleming <afleming@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2013 01:45 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-16 at 14:47 +1000, Benjamin Herrenschmidt wrote:
>> Hi folks !
>>
>> So I was trying to use my 5020ds to test some stuff today. Since I
>> hadn't used it in a while, I decided to "upgrade" it to the latest NOR
>> etc...
>
> On another note, I can't seem to get any PCIe card recognized in any
> slot...

This should depend on the RCW.

As I recall, slot 7 or slot 4 can be configured to support PCIe for P5020DS. And 
you can know this information according to RCW's README.

Tiejun
