Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 071E82BD46
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Oct 2004 04:11:00 +1000 (EST)
Date: Sun, 24 Oct 2004 11:10:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20041024181051.GA20064@smtp.west.cox.net>
References: <20041024160923.GA22167@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041024160923.GA22167@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] write gas check tmp file to O= directory
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 24, 2004 at 06:09:23PM +0200, Olaf Hering wrote:

> the tmp file should be in the O= directory.

[snip]
> @@ -132,5 +132,5 @@ endif
>  
>  CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
>  		arch/$(ARCH)/kernel/asm-offsets.s \
> -		$(TOUT)
> +		$(objdir)$(TOUT)

Having to do this seems wrong.  We don't need $(objdir) for any other
generated file in CLEAN_FILES.

-- 
Tom Rini
http://gate.crashing.org/~trini/
