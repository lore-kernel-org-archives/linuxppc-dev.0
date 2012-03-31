Return-Path: <rdunlap@xenotime.net>
Received: from oproxy4-pub.bluehost.com (oproxy4.bluehost.com
 [IPv6:2605:dc00:100:2::a4])
 by ozlabs.org (Postfix) with SMTP id D8A27B6F73
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 06:25:11 +1000 (EST)
Message-ID: <4F77681E.5010608@xenotime.net>
Date: Sat, 31 Mar 2012 13:25:02 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120331201500.GA27640@linas.org>
In-Reply-To: <20120331201500.GA27640@linas.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, dhowells@redhat.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux@arm.linux.org.uk,
 linux-hexagon@vger.kernel.org, x86@kernel.org, jejb@parisc-linux.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, cmetcalf@tilera.com,
 uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/31/2012 01:15 PM, Linas Vepstas wrote:

> 
> Hi,
> 
> I didn't actually try to compile the patch below; it didn't look like
> C code so I wasn't sure what compiler to run it through.  I guess maybe
> its python?  However, I'm very sure that the patches are completely
> correct, because I read them, and I also know Paul.  And I've heard of
> Thomas Gleixner.


x86_64 defconfig has many build errors and warnings.  :(

back to my abacus.

-- 
~Randy
