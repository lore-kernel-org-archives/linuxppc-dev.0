Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8D18DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 21:21:26 +1100 (EST)
In-Reply-To: <70840B5D-F927-4CC6-84D3-789DA8A66378@embeddedalley.com>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<70840B5D-F927-4CC6-84D3-789DA8A66378@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a11c8a770fa2fd412330b9d89d8ebe5f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Fri, 16 Feb 2007 11:21:19 +0100
To: Dan Malek <dan@embeddedalley.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Why do we need yet another syntax?  Everyone
> else, including most silicon documentation, uses
> the standard "C" syntax 0x for hex, 0 for octal, and
> nothing for decimal.

[Completely off-topic]

You're joking, right?  Many docs use 1234h for hex and
1011b for binary; or $1234 for hex and %1011 for binary;
or x'1234 and b'1011; or 1234_{(16)} and 1011_{(2)} (TeX
notation -- base as decimal in a parenthesised subscript);
etc. etc. etc.

Almost all computer languages use something more sane
than the C-family stuff too (esp. the dreaded "0 is
octal" thing is not exactly great).

Anyway, really off-topic :-)


Segher
