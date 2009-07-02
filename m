Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 5C52EB7111
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 07:39:16 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so748018rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Jul 2009 14:39:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ba63b520907021338n3c0d6d33g11d4934ccc538a94@mail.gmail.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
	<97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
	<1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
	<97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
	<4A4CBC0C.1040001@mlbassoc.com>
	<97dd5fd20907020927v2680a7f8m2657193394bd6323@mail.gmail.com>
	<97dd5fd20907021142i663de6aavc093fbd6ac5025c@mail.gmail.com>
	<1ba63b520907021338n3c0d6d33g11d4934ccc538a94@mail.gmail.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Thu, 2 Jul 2009 16:38:55 -0500
Message-ID: <97dd5fd20907021438ve8c72b9g168e4aa22e9f2f9f@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
To: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This is very interesting. I recently experienced a similar problem when
> upgrading from 2.6.26-rc6 to 2.6.31-rc1 (torvalds mainline kernel).
>
> I didn't had the time to figure out what was happening, so I went back to
> 2.6.26-rc6. Just for the test, could you try to go back to 2.6.26 and see if
> the problem remains?

Frank! That worked like a charm! I downloaded linux-2.6.26 source from
git.kernel.org, inserted the config options previously mentioned,
compiled ok, keeping U-Boot ramdisk and my DTS same it booted right up
and no more "slow motion" issue.

Thanks! Now I just need to make myself a custom ramdisk.
