Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CAAECB6FA9
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2011 03:32:04 +1000 (EST)
Received: by vwl1 with SMTP id 1so1025884vwl.15
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jun 2011 10:32:01 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <1307031956-11686-1-git-send-email-galak@kernel.crashing.org>
References: <1307031956-11686-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 2 Jun 2011 13:32:01 -0400
Message-ID: <BANLkTinQxjxefrCC0HDVGChzAKXoTBch7g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl_rio: Fix compile error when CONFIG_FSL_RIO
	not set
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 2, 2011 at 12:25 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> arch/powerpc/kernel/built-in.o: In function `machine_check_e500mc':
> arch/powerpc/kernel/traps.c:429: undefined reference to `fsl_rio_mcheck_exception'
> arch/powerpc/kernel/built-in.o: In function `machine_check_e500': arch/powerpc/kernel/traps.c:519:
> undefined reference to `fsl_rio_mcheck_exception'
> make: *** [.tmp_vmlinux1] Error 1
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Should be Reported-by Timur, right?

josh
