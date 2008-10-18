Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87614DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 23:58:40 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9ICwXON019056
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 08:58:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9ICwXHu104194
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 06:58:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9ICwWlK001184
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 06:58:33 -0600
Date: Sat, 18 Oct 2008 08:58:29 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "prodyut hazarika" <prodyuth@gmail.com>
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x
	PPC32 architectures.
Message-ID: <20081018085829.3757156e@zod.rchland.ibm.com>
In-Reply-To: <49c0ff980810170854jff48193r76a19c18497a1ec7@mail.gmail.com>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
	<49c0ff980810170854jff48193r76a19c18497a1ec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, pvr@emcraft.com,
	Ilya Yanok <yanok@emcraft.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 17 Oct 2008 08:54:52 -0700
"prodyut hazarika" <prodyuth@gmail.com> wrote:

> On Wed, Oct 15, 2008 at 7:22 PM, Ilya Yanok <yanok@emcraft.com> wrote:
> > This patch adds support for page sizes bigger than 4K (16K/64K) on
> > PPC 44x.
> >
> 
> This patch looks good to me. Seems that all the review comments have
> been incorporated.
> 
> Josh, it would be great if this patch is pulled into the mainline
> kernel. I have seen significant performance improvement with RAID0/5
> by using 64K pages.

It helps if you CC the person you're writing too :).

Anyway, I looked over it briefly and agree it looks pretty good.  A bit
late for 2.6.28, but I'll do a more thorough review and get it in for
2.6.29.

josh
