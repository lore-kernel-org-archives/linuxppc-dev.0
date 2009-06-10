Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2E2CAB720C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 02:36:14 +1000 (EST)
Message-ID: <4A2FE0E4.40503@am.sony.com>
Date: Wed, 10 Jun 2009 09:35:48 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 31/33] ps3: Replace direct file operations by callback
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-26-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-27-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-28-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-29-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-30-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-31-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-32-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-32-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2009 07:39 AM, Geert Uytterhoeven wrote:
> Currently the FLASH database is updated by the kernel using file operations,
> meant for userspace only. While this works for us because copy_{from,to}_user()
> on powerpc can handle kernel pointers, this is unportable and a bad example.
> Replace the file operations by callbacks, registered by the ps3flash driver.

Thanks for getting this one done.

> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Cc: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/include/asm/ps3.h       |    7 ++
>  arch/powerpc/platforms/ps3/os-area.c |  138 ++++++++++++++++++---------------
>  drivers/char/ps3flash.c              |   94 +++++++++++++++++------
>  3 files changed, 152 insertions(+), 87 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
