Return-Path: <SRS0+d99126679a6468e47a3e+1563+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: Merge dtc
From: David Woodhouse <dwmw2@infradead.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071016050217.GA9052@localhost.localdomain>
References: <20071016050217.GA9052@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 01:59:04 +0000
Message-Id: <1196733544.13978.201.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-16 at 15:02 +1000, David Gibson wrote:
> This very large patch incorporates a copy of dtc into the kernel
> source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> longer an external dependency to build kernels with configurations
> which need a dtb file.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Too big for the list, full patch at
> http://ozlabs.org/~dgibson/home/merge-dtc.patch

I think this is a bad idea -- it's hardly a difficult for those people
who _do_ need dts to obtain it separately.

It's bad enough that I have to separate out the bootwrapper code, which
probably ought to live outside the kernel. We shouldn't be merging
_more_ stuff in.

-- 
dwmw2
