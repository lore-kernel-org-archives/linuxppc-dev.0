Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9091B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 06:44:11 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 31 Mar 2012 14:44:07 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 43113C40002
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 14:43:44 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2VKhiWT156498
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 14:43:44 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2VKhgrw020781
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 14:43:44 -0600
Date: Sat, 31 Mar 2012 13:43:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120331204332.GH2450@linux.vnet.ibm.com>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120331201500.GA27640@linas.org> <4F77681E.5010608@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F77681E.5010608@xenotime.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, dhowells@redhat.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux@arm.linux.org.uk,
 linux-hexagon@vger.kernel.org, x86@kernel.org, jejb@parisc-linux.org,
 Linas Vepstas <linasvepstas@gmail.com>, cmetcalf@tilera.com,
 uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 31, 2012 at 01:25:02PM -0700, Randy Dunlap wrote:
> On 03/31/2012 01:15 PM, Linas Vepstas wrote:
> 
> > 
> > Hi,
> > 
> > I didn't actually try to compile the patch below; it didn't look like
> > C code so I wasn't sure what compiler to run it through.  I guess maybe
> > its python?  However, I'm very sure that the patches are completely
> > correct, because I read them, and I also know Paul.  And I've heard of
> > Thomas Gleixner.
> 
> 
> x86_64 defconfig has many build errors and warnings.  :(

I suggest removing the code containing the errors and warnings.  I bet
that the offending code is not needed when running with zero CPUs.

> back to my abacus.

;-)

							Thanx, Paul
