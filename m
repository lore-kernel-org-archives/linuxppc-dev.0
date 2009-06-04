Return-Path: <greg@kroah.com>
Date: Thu, 4 Jun 2009 11:07:36 -0700
From: Greg KH <greg@kroah.com>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
Message-ID: <20090604180736.GA24902@kroah.com>
References: <20090604133132.19010.16577.sendpatchset@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090604133132.19010.16577.sendpatchset@subratamodak.linux.ibm.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 04, 2009 at 07:01:32PM +0530, Subrata Modak wrote:
> CC [M]  drivers/staging/comedi/drivers.o
> drivers/staging/comedi/drivers.c: In function ‘comedi_buf_alloc’:
> drivers/staging/comedi/drivers.c:496: error: ‘PAGE_KERNEL_NOCACHE’ undeclared (first use in this function)
> drivers/staging/comedi/drivers.c:496: error: (Each undeclared identifier is reported only once
> drivers/staging/comedi/drivers.c:496: error: for each function it appears in.)
> make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
> make[2]: *** [drivers/staging/comedi] Error 2
> make[1]: *** [drivers/staging] Error 2
> make: *** [drivers] Error 2
> 
> Is it still normal to expect this failure ?

No.

> I reported them long back during April:
> http://www.gossamer-threads.com/lists/linux/kernel/1065227,

Yes, and I took some patches that were supposed to fix this.  I can't
duplicate this here, care to send a patch that would fix it?

thanks,

greg k-h
