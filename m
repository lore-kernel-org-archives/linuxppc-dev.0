Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id BF69ADDE04
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 12:31:43 +1000 (EST)
Date: Sun, 27 Apr 2008 22:31:42 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080427223142.399bbfe7@lappy.seanm.ca>
In-Reply-To: <20080428105859.daef4d71.sfr@canb.auug.org.au>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
	<20080428105859.daef4d71.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Apr 2008 10:58:59 +1000
"Stephen Rothwell" <sfr@canb.auug.org.au> wrote:

> You really want linux.of.h (unless there was some preexisting reason
> to require of_platform.h).

You are correct. That was a cut and paste from warp.c which
specifically needs of_platform.h.

Cheers,
   Sean
