Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 83AADDE4EF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 May 2008 03:49:45 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so437527pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 10:49:44 -0700 (PDT)
Date: Fri, 23 May 2008 12:49:40 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: - Reyneke <reynekejunk@hotmail.com>
Subject: Re: linux powerpc and device trees
Message-ID: <20080523124940.20e51d22@vader.jdub.homelinux.org>
In-Reply-To: <BAY101-W39CE5CDB63DCE2DC056AAFBEC10@phx.gbl>
References: <BAY101-W39CE5CDB63DCE2DC056AAFBEC10@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 23 May 2008 14:53:44 +0000
- Reyneke <reynekejunk@hotmail.com> wrote:

> memory {
> device_type = "memory";
> reg = ; /* Filled in by zImage */
> };
> 
> This is where I am unclear as to how to prepare the device tree. Is step (4) correct since I'm using uImage? Where is the memory information suppose to come from? Previously U-boot passes this kind of data to the kernel via bd_t - how does it work now using device trees?

As others have noted, U-Boot can fill in the device tree parts that are
missing if your version of U-Boot is FDT capable.  If not, you need to
use a cuImage wrapper to do that part for you.  See
arch/powerpc/boot/cuboot-sequoia.c for examples.

josh
