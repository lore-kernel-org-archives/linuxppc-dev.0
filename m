Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3B07DDF6D
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 20:30:34 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m89AULHM027430
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2008 06:30:21 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m89AUKVW234270
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2008 06:30:20 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m89AUKxe011283
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2008 06:30:20 -0400
Date: Tue, 9 Sep 2008 06:30:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 0/3 v2] ibm_newemac: Various fixes and additions for
	PPC405EZ
Message-ID: <20080909063008.15dfa6d0@zod.rchland.ibm.com>
In-Reply-To: <1220944283.4879.323.camel@pasglop>
References: <cover.1220877899.git.jwboyer@linux.vnet.ibm.com>
	<1220944283.4879.323.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 09 Sep 2008 17:11:23 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2008-09-08 at 08:44 -0400, Josh Boyer wrote:
> > The following patch series adds things needed to support the PowerPC 405EZ
> > SoC.  I've incorporated the suggestions and fixes from the previous round
> > of patches and barring any further comments these should be ready to go.
> 
> For some reason, I got this email but not the 3 following patch ones...

Erm.. odd.

http://patchwork.ozlabs.org/patch/208/
http://patchwork.ozlabs.org/patch/209/
http://patchwork.ozlabs.org/patch/210/

All of them were addressed to you and netdev, with linuxppc-dev on CC.
You should have gotten them..

josh
