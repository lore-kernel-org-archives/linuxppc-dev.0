Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE30FDDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 11:46:41 +1000 (EST)
Date: Mon, 17 Sep 2007 20:46:25 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] powerpc: Avoid pointless WARN_ON(irqs_disabled()) from
	panic codepath
Message-ID: <20070917204625.64b97392@vader.jdub.homelinux.org>
In-Reply-To: <20070917183749.fd690505.randy.dunlap@oracle.com>
References: <46EA5CEB.7020104@linux.vnet.ibm.com>
	<a781481a0709140337u2c26f770h2af6d457bc39f280@mail.gmail.com>
	<alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
	<20070917183749.fd690505.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mailing List <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linux@ozlabs.org, Satyam Sharma <satyam@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Sep 2007 18:37:49 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Tue, 18 Sep 2007 05:13:40 +0530 (IST) Satyam Sharma wrote:
> 
> > Untested (not even compile-tested) patch.
> > Could someone point me to ppc32/64 cross-compilers for i386?
> 
> OSDL had some, but those are gone now.
> I downloaded all of them and still use them, although it would
> be good to have some more recent versions of them.
> 
> I put the power* compiler tarballs here:
> 
> http://userweb.kernel.org/~rdunlap/cross-compilers/

Crosstool is widely used.  It'll build several combinations of
gcc/binutils/glibc for you.  

http://www.kegel.com/crosstool/

There's also the ELDK from Denx:  

http://www.denx.de/en/view/Software/WebHome#Embedded_Linux_Development_Kit

josh
