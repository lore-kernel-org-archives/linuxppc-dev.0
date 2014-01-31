Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by ozlabs.org (Postfix) with ESMTP id 301AA2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:45:50 +1100 (EST)
Date: Fri, 31 Jan 2014 14:21:24 +0900
From: Simon Horman <horms@verge.net.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] kexec/ppc64 fix device tree endianess issues for
 memory attributes
Message-ID: <20140131052124.GA25099@verge.net.au>
References: <20140130150622.11156.39497.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140130150622.11156.39497.stgit@nimbus>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 30, 2014 at 04:06:22PM +0100, Laurent Dufour wrote:
> All the attributes exposed in the device tree are in Big Endian format.
> 
> This patch add the byte swap operation for some entries which were not yet
> processed, including those fixed by the following kernel's patch :
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-January/114720.html
> 
> To work on PPC64 Little Endian mode, kexec now requires that the kernel's
> patch mentioned above is applied on the kexecing kernel.
> 
> Tested on ppc64 LPAR (kexec/dump) and ppc64le in a Qemu/KVM guest (kexec)
> 
> Changes from v1 :
>  * add processing of the following entries :
>    - ibm,dynamic-reconfiguration-memory
>    - chosen/linux,kernel-end
>    - chosen/linux,crashkernel-base & size
>    - chosen/linux,memory-limit
>    - chosen/linux,htab-base & size
>    - linux,tce-base & size
>    - memory@/reg
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.
