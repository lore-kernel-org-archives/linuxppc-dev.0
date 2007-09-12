Return-Path: <Monstr@seznam.cz>
Received: from mxh.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by ozlabs.org (Postfix) with SMTP id 2AC5CDDE3C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 17:34:37 +1000 (EST)
In-Reply-To: <20070912020339.GC16001@localhost.localdomain>
Date: Wed, 12 Sep 2007 09:34:33 +0200 (CEST)
To: =?us-ascii?Q?David=20Gibson?= <david@gibson.dropbear.id.au>
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20FDT=20for=20Microblaze=20and=20PPC405?=
Mime-Version: 1.0
Message-Id: <3266.6156-24105-795007998-1189582473@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: =?us-ascii?Q?linuxppc=2Ddev?= <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David and Grant

>> > For example emaclite driver needs information about turning on/off ping pong
buffer...
>> >
>> > I would like to make this properly.
>>
>> FDT design is just as much art as it is science.  It takes taste and
>> judgement to desgin a nice set of bindings.  Your best option is to
>> draft something and post it to the linuxppc-embedded mailing list for
>> review.
>
>Yes, this is the preferred procedure, for now.

OK. Science is good for me because I am looking for theme for dissertation thesis
and FPGA based FDT can be good choice.

>> > And second question is on early console logs and timers setting. I read
>about aliases in FDT. I think that aliases can cover this setting.
>> > For example my design contain 4 serial line and I would like to know which
>serial line is set on early console.
>>
>> You use the chosen node for this.  In the chosen node, you add a
>> property called "linux,stdout-path" which holds the path to your
>> console.  You can look at examples under arch/powerpc/boot/dts/*

>Yes.  Currently we don't use /aliases in the flat device tree.  This
>is possibly a mistake, and something I'm thinking about changing.
>But, for now, linux,stdout-path in /chosen is the way to do this.

OK. I will make the first draft and send it to list for review but it will be
only part of patch rely on with ppc405 because we don't have microblaze kernel code.

Michal Simek
