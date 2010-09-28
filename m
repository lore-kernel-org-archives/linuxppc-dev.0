Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id CBBB6B70F7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 21:40:46 +1000 (EST)
Received: by eyg24 with SMTP id 24so2550161eyg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 04:40:44 -0700 (PDT)
Date: Tue, 28 Sep 2010 15:40:32 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 1/3] powerpc/fsl_soc.c: remove FSL USB platform code
Message-ID: <20100928114032.GA27285@oksana.dev.rtsoft.ru>
References: <1285666594-21150-1-git-send-email-agust@denx.de>
	<1285666594-21150-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1285666594-21150-2-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Greg Kroah-Hartman <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2010 at 11:36:32AM +0200, Anatolij Gustschin wrote:
> This removed code will be replaced by simple of_platform
> driver for creation of FSL USB platform devices which is
> added by next patch of the series.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---

This is not bisectable. You have to merge 1/3 and 2/3.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
