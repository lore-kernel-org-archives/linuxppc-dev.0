Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] Please pull 'for-2.6.25' branch of cell tree
Date: Mon, 3 Mar 2008 09:14:57 +0100
References: <200802290612.56728.arnd@arndb.de>
	<1204265597.7729.27.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1204265597.7729.27.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200803030914.57836.arnd@arndb.de>
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 February 2008, Michael Ellerman wrote:
> On Fri, 2008-02-29 at 06:12 +0100, Arnd Bergmann wrote:
> > Hi Paul,
> > 
> > Please pull from:
> > 
> >  master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git for-2.6.25
> > 
> > To pick up a few small fixes for the cell platform. Most of it is a follow-up
> > to the IOMMU rework that got merged in 2.6.25-rc1 and caused problems on
> > machines with large amounts of memory.
> 
> Sorry, I have updated versions of the IOMMU patches to send. Arnd is
> away for the weekend, so Paul if you just want to cherry pick the other
> fixes that might work. I'll send the updated IOMMU patches momentarily.

The git tree should finally be fixed up now, same location as before,
commit ID is now da40451bba23b51eaca4170a095891646ce72104.

	Arnd <><
