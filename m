Return-Path: <cel@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [Patch 1/3] User OProfile support for the IBM
	CELL processor SPU	event profiling
From: Carl Love <cel@us.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1228179733.8004.45.camel@localhost>
References: <1228177110.6509.286.camel@carll-linux-desktop>
	<1228179733.8004.45.camel@localhost>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 07:57:11 -0800
Message-Id: <1228233431.6509.295.camel@carll-linux-desktop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cel <cel@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	oprofile-list@lists.sourceforge.net, cbe-oss-dev <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-12-02 at 12:02 +1100, Michael Ellerman wrote:
> On Mon, 2008-12-01 at 16:18 -0800, Carl Love wrote:
> > This patch adds the SPU event profiling support for the IBM Cell
> > processor to the list of available events. The opcontrol script
> > patches include a test to see if there is a new cell specific file
> > in the kernel oprofile file system.  If the file exists, then the
> > kernel supports SPU event profiling.  
> > 
> > Signed-off-by: Carl Love <carll@us.ibm.com>
> > 
> 
> > Index: oprofile-cvs/doc/oprofile.xml
> > ===================================================================
> > --- oprofile-cvs.orig/doc/oprofile.xml
> > +++ oprofile-cvs/doc/oprofile.xml
> > @@ -123,6 +123,10 @@ For information on how to use OProfile's
> >                         of 2.6.22 or more recent.  Additionally, full support of SPE profiling requires a BFD library
> >                         from binutils code dated January 2007 or later.  To ensure the proper BFD support exists, run
> >                         the <code>configure</code> utility with <code>--with-target=cell-be</code>.
> > +
> > +		       Profiling the Cell Broadband Engine using SPU events requires a kernel version of 2.6.TBD or
>                                                                                                                ^^^
> 
> Not sure if you missed that, or it's still TBD, but careful it doesn't
> get merged like that.
> 
> cheers
> 
Michael:

Yes, I am aware of it.  I felt it was important to post user and kernel
so everyone knows that user and kernel development is done.  I have
talked with the OProfile maintainer about these patches already.  The
plan is to update the user patch with the correct kernel version, once
we know which version the patches will be going into.  

I should have mentioned this specifically in patch 0/3.  I will need a
final spin of the user tool patch once the kernel patches are accepted.

Thanks.

                Carl Love
