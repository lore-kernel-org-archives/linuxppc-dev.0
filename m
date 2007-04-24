Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64A9EDDF36
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 03:01:06 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3OH13Nq030558
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:01:03 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3OH12Xd521236
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:01:03 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3OH0rFj004652
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:00:53 -0400
Date: Tue, 24 Apr 2007 12:00:52 -0500
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc: Abolish PHYS_FMT macro from arch/powerpc
Message-ID: <20070424170052.GW31947@austin.ibm.com>
References: <20070424050518.GC30007@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070424050518.GC30007@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 24, 2007 at 03:05:18PM +1000, David Gibson wrote:
> 32-bit powerpc systems define a macro, PHYS_FMT, giving a printf

Your patch removed the use of the macro, but does not remove the definition
of the macro.

--linas
