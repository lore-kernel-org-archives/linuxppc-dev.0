Return-Path: <tmorrison@empirix.com>
Received: from manexowa.empirix.com (unknown [66.151.190.243])
	by ozlabs.org (Postfix) with ESMTP id A8079B7B83
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 21:56:32 +1000 (EST)
From: "Morrison, Tom" <tmorrison@empirix.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 23 Sep 2009 07:56:27 -0400
Subject: RE: PCI HotPlug and Adding Resources after Linux Boots
Message-ID: <80955630EE34634AB5030FB8CE9BDCEFD74DA18D@EXBEDCLST.empirix.com>
References: <80955630EE34634AB5030FB8CE9BDCEFD7459DF2@EXBEDCLST.empirix.com>
	<1253698927.7103.312.camel@pasglop>
In-Reply-To: <1253698927.7103.312.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you for taking the time in confirming some of the=20
potential strategies I was already thinking about...:-)

I am going to try to pre-allocate some resources for
the specific port/slot/bridge device (because we know
at all times that port #6 (bus #5) is going to have
a FPGA end device associated with it...

Any other thoughts - whenever you can make them - would
be more than welcome!

Tom


>> -----Original Message-----
>> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>> Sent: Wednesday, September 23, 2009 5:42 AM
>> To: Morrison, Tom
>> Cc: linuxppc-dev@ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: PCI HotPlug and Adding Resources after Linux Boots
>>=20
>> On Tue, 2009-09-22 at 15:36 -0400, Morrison, Tom wrote:
>> > I am not exactly sure who to direct this question to (general Linux
>> > kernel or LinuxPPC),
>>=20
>> PCI Hotplug is reasonably arch specific at the moment so I suppose
>> here's is as good as anywhere else to ask :-)
>>=20
>> > so I am directing to both - in hopes that someone will recognize this
>> > problem - and perhaps
>> >
>> > give me some suggestions on how to proceed...
>>=20
>> There's a few things you can do, though I don't have time just right now
>> to give you a detailed answer. I'll try again later.
>>=20
>> In the meantime, some of the answers could be around not using full
>> automatic resource assignment, but instead, pre-initializing the top
>> bridge with some resources that are going to be enough for the device.
>>=20
>> You can also try to get the bridge to re-allocate. There's various funky
>> locking issues with doing that though as long as it's during boot time,
>> it's not too much of a problem.
>>=20
>> There are other more or less hackish ways to do it, but I'll have to
>> give it more thought.
>>=20
>> I'm quite stretched at the moment so if you don't hear back from me in
>> the upcoming few days, don't hesitate to ping me again.
>>=20
>> Cheers,
>> Ben.
>> >
>> > I am running Linux (2.6.23x (and 2.6.27.x)) on a MPC8572 based system.
>>=20
[Morrison, Tom]=20
<snip the rest original msg>
