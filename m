Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 56C0567FE1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 01:03:02 +1000 (EST)
Received: from liberty.homelinux.org ([70.190.160.125]) by fed1rmmtao01.cox.net
	(InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP id
	<20050818150259.KVCJ19627.fed1rmmtao01.cox.net@liberty.homelinux.org>
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 Aug 2005 11:02:59 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id IAA14781
	for linuxppc-embedded@ozlabs.org; Thu, 18 Aug 2005 08:03:01 -0700
Date: Thu, 18 Aug 2005 08:03:01 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050818080301.F14235@cox.net>
References: <20050817200547.GA21017@siegfried.thelikelysolution.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050817200547.GA21017@siegfried.thelikelysolution.ca>;
	from glikely@gmail.com on Wed, Aug 17, 2005 at 02:05:47PM -0600
Subject: Re: [PATCH] Fix for TLB errata on early Xilinx Virtex-II Pro silicon
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2005 at 02:05:47PM -0600, Grant Likely wrote:
>  config EMBEDDEDBOOT
>         bool
> -       depends on EP405 || XILINX_ML300
> +       depends on EP405 || VIRTEX_II_PRO
>         default y
> 

Grant,

Can you post another patch without this hunk?..as Andrei pointed
out, it's a board specific feature.

Otherwise, looks good to go upstream.

-Matt
