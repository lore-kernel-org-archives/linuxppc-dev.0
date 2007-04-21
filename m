Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Support 64K pages mapping of SPE local stores on
	4K kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200704212233.34521.arnd.bergmann@de.ibm.com>
References: <1172835163.743765.616483133775.qpush@grosgo>
	<200704212233.34521.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Sun, 22 Apr 2007 08:44:28 +1000
Message-Id: <1177195469.6080.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-04-21 at 22:33 +0200, Arnd Bergmann wrote:
> On Friday 02 March 2007, Benjamin Herrenschmidt wrote:
> > This serie of patches supports userland mappings of SPE local stores
> > using 64K hardware pages rather than 4K on a kernel using 4K pages to
> > improve performances.
> 
> Ben, I have problems porting these patches to powerpc.git#for-2.6.22.
> Could you port them yourself and submit them to Paul? What is the
> status of the second patch, do you have a version suitable for upstream?

I have more up to date versions of these, I'll do the port. The generic
change needs to be done differently for upstream. I've been posting
regulary a serie of patches that change get_unmapped_area() for that
which I hope will get upstream but I yet to have some feedback from
akpm...

Ben.
