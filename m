Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id E79FF67A7F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 10:14:34 +1100 (EST)
Date: Wed, 16 Feb 2005 16:14:32 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Andre' Draszik" <andid@gmx.net>
Message-ID: <20050216161432.B31885@cox.net>
References: <4206ED97.2060506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4206ED97.2060506@gmx.net>;
	from andid@gmx.net on Mon, Feb 07, 2005 at 05:24:55AM +0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] PPC4xx ocp ide rewrite/cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Feb 07, 2005 at 05:24:55AM +0100, Andre' Draszik wrote:
> Hi,
> 
> this is a rewrite of the ibm4xx ocp ide driver. In its current state it
> doesn't compile with current 2.6 and is completely broken in many other
> aspects anyway.
> Please consider applying (or tell me how the patch should be changed to
> qualify for applying :)
> 
> Signed-off-by: Andre' Draszik <andid@gmx.net>
> 
> diff -urN -X dontdiff linuxppc-2.5.orig/drivers/ide/Kconfig linuxppc-2.5/drivers/ide/Kconfig

I tried applying this to current linuxppc-2.5. All hunks are rejected.
Can you double check this patch and resend?

-Matt
