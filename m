Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20071016050217.GA9052@localhost.localdomain>
References: <20071016050217.GA9052@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Merge dtc
Date: Tue, 16 Oct 2007 00:08:06 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2007, at 12:02 AM, David Gibson wrote:

> This very large patch incorporates a copy of dtc into the kernel
> source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> longer an external dependency to build kernels with configurations
> which need a dtb file.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>
> Too big for the list, full patch at
> http://ozlabs.org/~dgibson/home/merge-dtc.patch

Dare I ask why we are including dtc in the kernel source tree?  We  
don't really have precedence for this and there are users outside of  
linux for dtc.

- k
