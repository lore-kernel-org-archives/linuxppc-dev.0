Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF43EDDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 00:05:34 +1000 (EST)
In-Reply-To: <20070613045256.E9CA3DDE25@ozlabs.org>
References: <20070613045256.E9CA3DDE25@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b434fc8e9be3463d2e11b4bb08fa73c4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/13] Start factoring pgtable-ppc32.h and pgtable-ppc64.h
Date: Thu, 14 Jun 2007 16:05:28 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)

Patch is mangled...  This is from the raw source I
received, it isn't my mail reader this time ;-)


Segher
