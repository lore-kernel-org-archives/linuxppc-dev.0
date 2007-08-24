Return-Path: <FENKES@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 256FCDDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 10:37:57 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7O0bpdx224516
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 00:37:51 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7O0bp6a2248724
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 02:37:51 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7O0bpnB024348
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 02:37:51 +0200
In-Reply-To: <91dcfc2a1b0be436d04f9bc45bb6f8657a8d6ff4.1187912217.git.jesper.juhl@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 04/30] powerpc: Don't cast kmalloc return value in
	ibmebus.c
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFAB12DB94.3E0F2BF6-ONC1257341.00034D6B-C1257341.00037513@de.ibm.com>
Date: Fri, 24 Aug 2007 02:37:49 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Heiko J Schick <schickhj@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Jesper Juhl <jesper.juhl@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> kmalloc() returns a void pointer so there is absolutely no need to
> cast it in ibmebus_chomp().
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Acked-By: Joachim Fenkes <fenkes@de.ibm.com>
