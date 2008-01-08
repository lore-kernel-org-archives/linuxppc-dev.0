Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 85C69DDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 12:55:53 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3779354pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 07 Jan 2008 17:55:52 -0800 (PST)
Date: Mon, 7 Jan 2008 19:55:47 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: "tony" <hangtoo@163.com>, jie han <jiehanca@yahoo.com.cn>
Subject: Re: How to config linux kernel(ARCH=powerpc)?
Message-ID: <20080107195547.1c71f42b@hansolo.jdub.homelinux.org>
In-Reply-To: <200801080918222817608@163.com>
References: <200801080918222817608@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 8 Jan 2008 09:18:23 +0800
"tony" <hangtoo@163.com> wrote:

> hi Jie
> maybe you should try it like this:
> linux-2.6-denx->make ARCH=ppc CROSS_COMPILE=ppc_4xx- pasemi_defconfig
> make sure you have installed the ppc_4xx- tools.

Um.. no.  pasemi is a 64bit CPU.  Get the powerpc tree from kernel.org,
make sure you have a PowerPC 64bit toolchain, and try with make
ARCH=powerpc

josh
