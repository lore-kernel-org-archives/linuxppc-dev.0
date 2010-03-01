Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 15:29:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC: PATCH 06/13] powerpc/4xx: Simple platform for the ISS
	4xx simulator
Message-ID: <20100301202910.GC8963@zod.rchland.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191337.20987.58130.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100301191337.20987.58130.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 01, 2010 at 12:16:00PM -0700, Dave Kleikamp wrote:
>diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
>index 1dfc1c1..915c295 100644
>--- a/arch/powerpc/platforms/44x/Kconfig
>+++ b/arch/powerpc/platforms/44x/Kconfig
>@@ -162,6 +162,17 @@ config YOSEMITE
> 	help
> 	  This option enables support for the AMCC PPC440EP evaluation board.
>
>+config ISS4xx
>+	bool "ISS 4xx Simulator"
>+	depends on (44x || 40x)
>+	default n
>+	select 405GP if 40x
>+	select 440GP if 44x

Won't that now build a 44x_46x kernel due to the 'select 440GP' there?  If so,
doesn't that cause issues for 476?  Confused...

josh
