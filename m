Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BBB54B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 21:32:42 +1000 (EST)
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C3F3DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 21:32:41 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n75BW2uY024165
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 07:32:02 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75BWYbR177914
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 07:32:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n75BTnWp028351
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 07:29:49 -0400
Date: Wed, 5 Aug 2009 07:32:30 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix switch_mmu_context to iterate of the
	proper list of cpus
Message-ID: <20090805113230.GB8985@zod.rchland.ibm.com>
References: <1249443212-25588-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1249443212-25588-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 04, 2009 at 10:33:32PM -0500, Kumar Gala wrote:
>Introduced a temporary variable into our iterating over the list cpus
>that are threads on the same core.  For some reason Ben forgot how for
>loops work.

Have the powerpoint demons corrupted him already??

josh
