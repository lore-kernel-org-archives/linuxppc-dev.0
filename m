Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18030.32600.921348.218117@cargo.ozlabs.ibm.com>
Date: Tue, 12 Jun 2007 21:11:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/10] powerpc: Move CONFIG_PPC64 into CPU selection
In-Reply-To: <200706121008.01661.arnd@arndb.de>
References: <20070611232824.489103547@arndb.de>
	<20070611233353.734704855@arndb.de>
	<18030.15937.699275.958545@cargo.ozlabs.ibm.com>
	<200706121008.01661.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> Can you eleborate, other than stating the exact opposite of what
> my comment said?

It's mostly subjective, I guess.  None of the reasons you've cited
seem at all compelling to me, and if we change this stuff then we'll
all get unnecessary questions next time we make a kernel.  Anyway I
like it the way it is, and I'm the maintainer. :)

> * The only major difference between ppc64 and the others is the
>   object format of the kernel binary.

I disagree with that.  There are major differences at the
implementation level for a lot of things.

Paul.
