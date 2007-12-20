Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A039DDEF9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 07:07:44 +1100 (EST)
Date: Thu, 20 Dec 2007 12:06:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 1/3] ps3: vuart: fix error path locking
Message-Id: <20071220120635.d66550bd.akpm@linux-foundation.org>
In-Reply-To: <1198179145.10713.9.camel@imap.mvista.com>
References: <20071213003028.676998182@mvista.com>
	<4760922C.2060908@am.sony.com>
	<20071218171050.5bf220fa.akpm@linux-foundation.org>
	<47688A5A.1090902@am.sony.com>
	<1198179145.10713.9.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: matthias.kaehlcke@gmail.com, linux-kernel@vger.kernel.org, linux@bohmer.net,
	linuxppc-dev@ozlabs.org, mingo@elte.hu, kjwinchester@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Dec 2007 11:32:25 -0800 Daniel Walker <dwalker@mvista.com> wrote:

> On Tue, 2007-12-18 at 19:04 -0800, Geoff Levand wrote:
> 
> > Unfortunately there wasn't enough context in the patch to see
> > that there is a down() earlier in the routine, and that the patch
> > does indeed remove an incorrectly placed down().  Here is the
> > entire routine, marked with what the patch removes.
> > 
> 
> Andrew have you had a chance to review this?
> 

Confused.  I did review it: http://lkml.org/lkml/2007/12/18/384
