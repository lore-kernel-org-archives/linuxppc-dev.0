Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC875DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 08:22:16 +1100 (EST)
Date: Mon, 30 Mar 2009 14:18:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] hvc_console: prevent wrapping in hvc_console_print()
Message-Id: <20090330141852.59baaeda.akpm@linux-foundation.org>
In-Reply-To: <20090330205553.GA19278@yoda.jdub.homelinux.org>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
	<20090330205553.GA19278@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, roel.kluin@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 30 Mar 2009 16:55:53 -0400
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Mon, Mar 30, 2009 at 01:35:31PM -0700, Andrew Morton wrote:
> >Guys, could we have a MAINTAINERS entry for this driver please?
> 
> To my knowledge, there isn't one.  Would be Ben now by default I
> guess.  The previous developers have disclaimed ownership for a
> while from what I remember.
> 

A MAINAINERS record doesn't have to identify an individual.  It can at
least point people at the appropriate mailing list(s).
