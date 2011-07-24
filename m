Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ECEA0B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jul 2011 02:48:21 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH 2/5] hugetlb: add phys addr to struct huge_bootmem_page
Date: Sun, 24 Jul 2011 16:48:13 +0000
Message-ID: <CAOZdJXWUydw_9W-7g_TydpxY22Pq1ntba_HRLZQK3opvHnwjTQ@mail.gmail.com>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
	<13092910103675-git-send-email-beckyb@kernel.crashing.org>
	<1309297166.32158.461.camel@pasglop>
	<786B027A-4EC8-4175-A18D-9DA57E9549D6@kernel.crashing.org>
In-Reply-To: <786B027A-4EC8-4175-A18D-9DA57E9549D6@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "List
	linux-kernel@vger.kernel.org Mailing" <linux-kernel@vger.kernel.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 30, 2011 at 1:50 PM, Becky Bruce <beckyb@kernel.crashing.org> w=
rote:

> Because there was no bootmem allocation in the normal case - the non-high=
mem
> version stores data structure in the huge page itself. =A0This is perfect=
ly fine as long
> as you have a mapping. =A0Since this isn't true for HIGHMEM pages, I allo=
cate
> bootmem to store the early data structure that stores information about t=
he
> hugepage (this happens in arch-specific code in alloc_bootmem_huge_page).

I would put this text in a comment in the code.

--=20
Timur Tabi
Linux kernel developer at Freescale=
