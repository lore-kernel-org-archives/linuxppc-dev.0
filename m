Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BB2962C007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 10:18:00 +1000 (EST)
Subject: Re: Probing for native availability of isel from userspace
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1348606771.7937.8.camel@pasglop>
Date: Tue, 25 Sep 2012 19:17:58 -0500
Message-Id: <DD2D64F0-6EC8-4205-AB81-52534C28DBD2@kernel.crashing.org>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
 <20120922102151.GA31314@visitor2.iram.es>
 <alpine.LNX.2.00.1209221936330.3878@linmac>
 <BB86F53C-6C09-41DB-9FF3-38E3027BCC82@kernel.crashing.org>
 <1348343737.1132.74.camel@pasglop>
 <35A5B006-1E4E-4355-A6A4-CA5F7371D21C@kernel.crashing.org>
 <20120924075546.GA4263@visitor2.iram.es> <1348473517.1132.87.camel@pasglop>
 <20120924080633.GA8127@visitor2.iram.es> <1348479715.1132.91.camel@pasglop>
 <CA1BC0F6-577D-4CEF-85C9-599774B176C9@kernel.crashing.org>
 <1348606771.7937.8.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, malc <av1474@comtv.ru>,
 hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 25, 2012, at 3:59 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2012-09-25 at 15:17 +0200, Segher Boessenkool wrote:
>>>> Fine. But I believe that mfpvr emulation came first, which is the =20=

>>>> point
>>>> I object to (see the mess that the fact that CPUID is available to
>>>> applications made to x86 when SSE registers were added).
>>>=20
>>> Heh, possibly, I don't remember... I added the cputable, I think we
>>> added mfpvr because we didn't have anything, then I added cputable =20=

>>> which
>>> got us the HW caps, but some old stuff still relied on mfpvr so we
>>> couldn't completely remove it.
>>=20
>> If I have my history right end up, MFPVR emulation was added for MoL.
>> Which is funny (if you like that kind of thing) because it now hurts
>> all other "hypervisor in userspace" kind of things, that might want
>> to lie in their emulated PVR...
>=20
> Are you sure ? MOL had a kernel module, it wouldn't have needed =
that...

I feel like there was some JVMs (IBMs?) that used MFPVR to determine =
some things.

- k=
