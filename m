Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19212.41144.253618.357013@cargo.ozlabs.ibm.com>
Date: Wed, 25 Nov 2009 14:12:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/3] Kernel handling of Dynamic Logical Partitioning
In-Reply-To: <4B0C8B45.6080804@austin.ibm.com>
References: <4B0C8B45.6080804@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, lkml@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot writes:

> The Dynamic Logical Partitioning (DLPAR) capabilities of the powerpc pseries
> platform allows for the addition and removal of resources (i.e. cpus,
> memory, pci devices) from a partition. The removal of a resource involves
> removing the resource's node from the device tree and then returning the
> resource to firmware via the rtas set-indicator call.  To add a resource, it
> is first obtained from firmware via the rtas set-indicator call and then a
> new device tree node is created using the ibm,configure-coinnector rtas call
> and added to the device tree.
> 
> The following set of patches implements the needed infrastructure to have the
> kernel handle the DLPAR addition and removal of cpus (other DLPAR'able items 
> to follow in future patches).  The framework for this is to create a set of 
> probe/release sysfs files that will facilitate arch-specific call-outs to 
> handle addition and removal of cpus to the system.

Nice explanation, but the 0/3 of the series doesn't go into git.
Could you rework some/all of this into the commit message for patch
1/3 so it gets stored permanently with these patches in git?

Thanks,
Paul.
