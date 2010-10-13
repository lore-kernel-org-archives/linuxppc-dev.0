Return-Path: <timur.tabi@gmail.com>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 249A8B6EF7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 08:03:00 +1100 (EST)
Received: by yxn22 with SMTP id 22so2550387yxn.15
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 14:02:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1286997576-4988-1-git-send-email-timur@freescale.com>
References: <1286997576-4988-1-git-send-email-timur@freescale.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Wed, 13 Oct 2010 16:02:28 -0500
Message-ID: <AANLkTimTGwEzbSc2t=njs8rpLFS9azo1CgKAMd9Q27sE@mail.gmail.com>
Subject: Re: [PATCH] powerpc: change the Book-E watchdog driver default
	timeout into a Kconfig option
To: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 13, 2010 at 2:19 PM, Timur Tabi <timur@freescale.com> wrote:

> the value a Kconfig option allows BSPs to configure a new value with requiring

That should say, "without requiring"

-- 
Timur Tabi
Linux kernel developer at Freescale
