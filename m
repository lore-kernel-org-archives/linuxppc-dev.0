Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id B2857DDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 02:08:46 +1000 (EST)
Received: by gxk14 with SMTP id 14so5657224gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 09:08:44 -0700 (PDT)
Message-ID: <ed82fe3e0809240908k4e60982ue1fdeb9f2b3bfc6@mail.gmail.com>
Date: Wed, 24 Sep 2008 11:08:44 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] powerpc: enforce sane MAX_ORDER
In-Reply-To: <1222266548.4257.26.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1222262654.4257.4.camel@johannes.berg>
	<B38CBE3A-B9DA-44BA-8646-AEE81FB82437@kernel.crashing.org>
	<1222265583.4257.21.camel@johannes.berg>
	<61059ECE-2B42-46B3-B5B3-E5CFA3A5EFC9@kernel.crashing.org>
	<1222266548.4257.26.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2008 at 9:29 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:

> Indeed, it makes little sense to allow you to set more than the address
> space, so here's a version with max 64.

Acked-by: Timur Tabi <timur@freescale.com>

However, the max is actually less than 64.  Assuming a 64-bit address
space, the maximum number of pages in one allocation can be
2^(64-PAGE_SHIFT).  For 4KB pages, the max value for
FORCE_MAX_ZONEORDER is 53.  For 64KB pages, the max is 49.

-- 
Timur Tabi
Linux kernel developer at Freescale
