Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Apr 2013 22:16:21 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Dennis Schridde <devurandom@gmx.net>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no
 threads shown in spufs
Message-ID: <20130423121620.GB27200@concordia>
References: <1470334.YUWOQ37ijW@ernie>
 <20130423140116.0a40c2c6@samson>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130423140116.0a40c2c6@samson>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 02:01:16PM +0200, Dennis Schridde wrote:
> Am Mon, 22 Apr 2013 18:44:13 +0200
> schrieb Dennis Schridde <devurandom@gmx.net>:
> > [4.] Kernel information
> > 
> > [4.1.] Kernel version (from /proc/version):
> > I am using the Linux 3.8.8 kernel (vanilla-sources-3.8.8 on
> > Gentoo/Linux): # cat /proc/version 
> > Linux version 3.8.8 (root@blade00) (gcc version 4.7.2 (Gentoo
> > 4.7.2-r1 p1.5, pie-0.5.5) ) #2 SMP Mon Apr 22 18:21:20 CEST 2013
> 
> Actually this is only partially correct.
> 
> I applied following patch by Grant Likely
> <grant.likely@secretlab.ca> to fix some IRQ mapping problems:

Ah yes, I forgot I also have basically the same patch. I've just sent it
to the list.

We appear to have a number of problems with the irq mapping on cell,
that patch fixes the worst of them but there are more.

cheers
