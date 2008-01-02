Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62673DDEB8
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 08:58:00 +1100 (EST)
Date: Wed, 2 Jan 2008 22:57:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH -mm] compat_binfmt_elf Kconfig
Message-ID: <20080102215738.GA17797@elte.hu>
References: <20071223183920.GA13976@elte.hu>
	<20071223211603.3FFB126F8E7@magilla.localdomain>
	<20071230163614.GB1384@elte.hu>
	<20080102044157.A5CC526F99F@magilla.localdomain>
	<20080102111431.GD14731@elte.hu>
	<20080102191030.GA11217@uranus.ravnborg.org>
	<20080102210831.9F80426F9A0@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080102210831.9F80426F9A0@magilla.localdomain>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Roland McGrath <roland@redhat.com> wrote:

> This patch should go in immediately after:
> 
> 	commit 5e45efc63e33ee2bae9ff4d500b53d3bf86d2b48
> 	Author: Roland McGrath <roland@redhat.com>
> 
> 	    compat_binfmt_elf
> 
> Thanks,
> Roland
> 
> ---
> [PATCH] compat_binfmt_elf Kconfig

thanks, applied.

	Ingo
