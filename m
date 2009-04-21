Return-Path: <david-b@pacbell.net>
From: David Brownell <david-b@pacbell.net>
To: subrata@linux.vnet.ibm.com
Subject: Re: [BUILD FAILURE 11/12] Next April 21 : PPC64 randconfig
	[drivers/usb/host/ohci-hcd.o]
Date: Tue, 21 Apr 2009 12:03:36 -0700
References: <1240340081.9110.144.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1240340081.9110.144.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200904211203.36969.david-b@pacbell.net>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-usb@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 21 April 2009, Subrata Modak wrote:
> Observing this for the first time:
> 
> CC      drivers/usb/host/ohci-hcd.o
> In file included from drivers/usb/host/ohci-hcd.c:1060:
> drivers/usb/host/ohci-ppc-of.c:242:2: error: #error "No endianess

Hmm, scripts/get_maintainer.pl doesn't report
the PPC folk who maintain that file and its
kbuild infrastructure.

Can we have some PPC folk look at (and fix) this?


> selected for ppc-of-ohci"
> make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
> make[2]: *** [drivers/usb/host] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> ---
> 
> Regards--
> Subrata
> 
> 
