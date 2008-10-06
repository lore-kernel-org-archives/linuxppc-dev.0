Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id BA55BDDE25
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 08:52:21 +1100 (EST)
Received: by gxk14 with SMTP id 14so7819075gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Oct 2008 14:52:20 -0700 (PDT)
Message-ID: <ed82fe3e0810061452k4887e652y9e0cd266447fb0e5@mail.gmail.com>
Date: Mon, 6 Oct 2008 16:52:20 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: remove CHRP and PMAC support from defconfigs,
	fix Kconfigs
In-Reply-To: <1222449586-14622-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1222449586-14622-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 26, 2008 at 12:19 PM, Timur Tabi <timur@freescale.com> wrote:
> The Kconfig files for PowerPC CHRP and PMAC support had "default=y" for some
> Kconfig options, and this caused support for CHRP and PMAC platforms to be
> enabled incorrectly for several platforms.  Fix the Kconfigs and the
> affected defconfigs.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch is for 2.6.28.  Ben, please review and make sure I'm not being to
> conservative or too aggressive.  I don't know enough about CHRP and PMAC to
> be sure I'm doing this right.

Ping.

-- 
Timur Tabi
Linux kernel developer at Freescale
