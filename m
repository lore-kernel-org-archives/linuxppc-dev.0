Return-Path: <arnd@arndb.de>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.17.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0BA7B7BA1
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 00:31:03 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.1/8.13.1) with ESMTP id n9DDUw5C003017
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 13:30:58 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n9DDUwSp2686998
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 15:30:58 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n9DDUvom014848
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 15:30:58 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org, michael@ellerman.id.au
Subject: Re: [Patch] powerpc: Fix memory leak in axon_msi.c
Date: Tue, 13 Oct 2009 15:30:56 +0200
References: <1255393780.9570.3.camel@concordia>
In-Reply-To: <1255393780.9570.3.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200910131530.56493.arnd@arndb.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, eric.sesterhenn@lsexperts.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 13 October 2009, Michael Ellerman wrote:
> cppcheck found a memory leak in axon_msi, if dcr_base or dcr_len are zero,
> we have already allocated msic, so we should free it in the error path.
> 
> Signed-off-by: Eric Sesterhenn <eric.sesterhenn@lsexperts.de>
> Acked-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
