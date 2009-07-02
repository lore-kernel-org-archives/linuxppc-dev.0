Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1271EB7115
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 07:49:19 +1000 (EST)
Message-ID: <4A4D2B70.1030505@freescale.com>
Date: Thu, 02 Jul 2009 16:49:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Subject: Re: RAMDISK on EP88xc
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
	<97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
	<1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
	<97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
	<4A4CBC0C.1040001@mlbassoc.com>	<97dd5fd20907020927v2680a7f8m2657193394bd6323@mail.gmail.com>
	<97dd5fd20907021142i663de6aavc093fbd6ac5025c@mail.gmail.com>
	<1ba63b520907021338n3c0d6d33g11d4934ccc538a94@mail.gmail.com>
	<97dd5fd20907021438ve8c72b9g168e4aa22e9f2f9f@mail.gmail.com>
In-Reply-To: <97dd5fd20907021438ve8c72b9g168e4aa22e9f2f9f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: =?UTF-8?B?RnJhbmsgU3ZlbmRzYsO4ZQ==?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mikhail Zaturenskiy wrote:
>> This is very interesting. I recently experienced a similar problem when
>> upgrading from 2.6.26-rc6 to 2.6.31-rc1 (torvalds mainline kernel).
>>
>> I didn't had the time to figure out what was happening, so I went back to
>> 2.6.26-rc6. Just for the test, could you try to go back to 2.6.26 and see if
>> the problem remains?
> 
> Frank! That worked like a charm! I downloaded linux-2.6.26 source from
> git.kernel.org, inserted the config options previously mentioned,
> compiled ok, keeping U-Boot ramdisk and my DTS same it booted right up
> and no more "slow motion" issue.

If you have time, could you bisect to see when the slowdown was introduced?

-Scott
