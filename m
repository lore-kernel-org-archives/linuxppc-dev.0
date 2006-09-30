Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17694.23677.886959.674776@cargo.ozlabs.ibm.com>
Date: Sat, 30 Sep 2006 22:01:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] Change ucc_geth driver to use of_device
In-Reply-To: <451E4808.7010004@freescale.com>
References: <451E4808.7010004@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang writes:

> This patch change ucc_geth driver to use of_device from
> platform_device.  It also fix a bug that bcsr_regs gets
> accidentally unmapped.  Remove trailing space.

So, does this go on top of your series of 9 patches, or is it instead
of one of them?

Paul.
