Return-Path: <Peter.Oberparleiter@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97FB2DDE09
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 01:46:51 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id m71FkUb4025050
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 15:46:30 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m71FkUGa2891808
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 17:46:30 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m71FkTPs012795
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 17:46:29 +0200
In-Reply-To: <20080801052936.GZ20457@bakeyournoodle.com>
To: Tony Breeds <tony@bakeyournoodle.com>
MIME-Version: 1.0
Subject: Re: [BUILD-FAILURE] 2.6.27-rc1-mm1 - allyesconfig build fails on
	powerpc
Message-ID: <OFD20F5EDA.300B66D1-ONC1257498.00561E0E-C1257498.00567026@de.ibm.com>
From: Peter 1 Oberparleiter <Peter.Oberparleiter@de.ibm.com>
Date: Fri, 1 Aug 2008 17:44:07 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds <tony@bakeyournoodle.com> wrote on 01.08.2008 07:29:36:

> On Thu, Jul 31, 2008 at 06:13:28PM +0530, Kamalesh Babulal wrote:
> > Hi Andrew,
> > 
> > make allyesconfig with 2.6.27-rc1-mm1 kernel on powerpc fails with
> build error
> 
> <snip>
> 
> Turning off GCOV "fixes" this.  Not really the best solution but at
> least it narrows doen the search effort.
> 
> Peter,
>    Can you have a look at how this can be fixed, if at all?

I did some testing with a cross-compiler myself and I don't think
there is a general solution to this problem. It's not one particular
file that is causing the problem but seemingly the sheer size of the
resulting vmlinux file - even though the toal vmlinux.o size is
"merely" up about 100MiB (from around 1,03Gib to 1,13Gib).

I think I'll need help from people with knowledge of the powerpc
toolchain here.


Regards,
  Peter
