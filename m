Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 5B7802BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 01:38:31 +1000 (EST)
Date: Thu, 7 Oct 2004 08:38:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041007153829.GD14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410051330310.5314@dell.enoriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410051330310.5314@dell.enoriver.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] first in a series to enhance microcode patches
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Oct 05, 2004 at 01:32:11PM -0400, Robert P. J. Day wrote:

>   resend of previous patch -- sorry, forgot the developer's cert of 
> origin.  please be patient, i'm slowly getting the hang of this.
> 
>   purpose of patch:
> 
>   1) adds a relocation pointer to smc_uart_t
>   2) redeclares reserved chunks in structures to be in terms of a
>      standard char array, rather than the hideous combination of uint,
>      ushort, and so on.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

Applied.

-- 
Tom Rini
http://gate.crashing.org/~trini/
