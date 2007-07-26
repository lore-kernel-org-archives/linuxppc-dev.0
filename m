Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18088.10923.67233.336636@cargo.ozlabs.ibm.com>
Date: Thu, 26 Jul 2007 15:01:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH] fix ppc kernels after build-id addition
In-Reply-To: <Pine.SOC.4.64.0707251301200.21641@math.ut.ee>
References: <Pine.SOC.4.64.0707251301200.21641@math.ut.ee>
Cc: linuxppc-dev@ozlabs.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Meelis Roos writes:

> This patch fixes arch/ppc kernels, at least for prep subarch, after 
> build-id addition. Without the patch, kernels were 3 times the size and 
> bootloader refused to load them. Now they are back to normal again.

I just built an ARCH=ppc kernel for the prep subarch and the vmlinux
size was normal.  Can you identify exactly why the kernels got so much
bigger, i.e. what is taking up all the space?

Paul.
