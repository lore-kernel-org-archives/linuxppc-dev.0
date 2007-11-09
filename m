Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F9B4DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 15:36:18 +1100 (EST)
Date: Thu, 8 Nov 2007 20:35:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] Fix typo #ifdef -> #ifndef
Message-Id: <20071108203552.bcc1e5a8.akpm@linux-foundation.org>
In-Reply-To: <472CC914.3030709@scram.de>
References: <472CC914.3030709@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Sat, 03 Nov 2007 20:16:36 +0100 Jochen Friedrich <jochen@scram.de> wrote:
> Subject: [PATCH] [POWERPC] Fix typo #ifdef -> #ifndef

Please put the "powerpc" outside the [].  Because things inside [] get
removed when the receiver applies the patch, but the subsystem
identification ("powerpc") is useful information which we want to carry
into the permanent git record. (Although Paul might add it anyway - some
git tree maintainers do).

> User-Agent: Mozilla-Thunderbird 2.0.0.6 (X11/20071009)

This seems to be setting a record for MUA vandalism.  Leading spaces were
removed and various esoteric whitespace transformations were made.  The
diffs were small so I fixed them by hand.

Please strangle your email client.
