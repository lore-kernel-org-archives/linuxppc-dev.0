Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 95FC4DDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:16:49 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1C2F1@az33exm25.fsl.freescale.net>
References: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
	<F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1C2F1@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0B394386-47DB-47C1-A3F3-BCE80F30B528@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: macros and dtc
Date: Mon, 19 Feb 2007 15:16:49 -0500
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2007, at 1:57 PM, Yoder Stuart-B08248 wrote:

> bus-frequency = <33MHZ> is much better than
> bus-frequency = <13ab6680>

Except, 33MHZ isn't a valid macro name, and if
these constants would have been _decimal_
in the first place, 33000000, or 33333333 would
be understandable :-)  I've screwed up by thinking
(or not, I guess) these are decimal numbers.....
I agree with you, though.  Of course, these values
should be zero in the dts and filled in by
the boot loader/wrapper.

A real programmer would recognize these
standard constants in hex (or octal), too :-)


Thanks.

	-- Dan
