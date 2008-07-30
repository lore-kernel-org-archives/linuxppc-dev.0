Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90215DE058
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 18:43:21 +1000 (EST)
Date: Wed, 30 Jul 2008 01:43:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric Munson <ebmunson@us.ibm.com>
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
Message-Id: <20080730014308.2a447e71.akpm@linux-foundation.org>
In-Reply-To: <cover.1216928613.git.ebmunson@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008 12:17:10 -0700 Eric Munson <ebmunson@us.ibm.com> wrote:

> Certain workloads benefit if their data or text segments are backed by
> huge pages.

oh.  As this is a performance patch, it would be much better if its
description contained some performance measurement results!  Please.
