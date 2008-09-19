Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4AA4EDDF21
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 00:00:40 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8JE0bdn019946
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 10:00:37 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8JE0baU106636
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 10:00:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8JE0bIq002949
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 10:00:37 -0400
Date: Fri, 19 Sep 2008 10:00:35 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Remove obsolete junk in Documentation/powerpc
Message-ID: <20080919100035.734b6e7a@zod.rchland.ibm.com>
In-Reply-To: <1221590682.12463.46.camel@pasglop>
References: <1221590682.12463.46.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 16 Sep 2008 11:44:42 -0700
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> We have all sort of totally rotten pieces of documentation
> in there, let's get rid of them
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Geert's two patches for ppc_htab.txt and smp.txt are more complete as
they remove the references in 00-INDEX as well.

josh
