Return-Path: <vapier.adi@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id EFFFBDDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 12:23:35 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so135130yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 17:23:33 -0800 (PST)
Message-ID: <8bd0f97a0811251723j7bac6964u237aa6c1228a7d89@mail.gmail.com>
Date: Tue, 25 Nov 2008 20:23:33 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Grant Erickson" <gerickson@nuovations.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <1227638045-12862-1-git-send-email-gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1227638045-12862-1-git-send-email-gerickson@nuovations.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Wolfgang Denx <wd@denx.de>, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 25, 2008 at 13:34, Grant Erickson wrote:
> This merges support for the previously DENX-only kernel feature of
> specifying an alternative, "external" buffer for kernel printk
> messages and their associated metadata. In addition, this ports
> architecture support for this feature from arch/ppc to arch/powerpc.
>
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>
> ---
>
> When this option is enabled, an architecture- or machine-specific log
> buffer is used for all printk messages. This allows entities such as
> boot loaders (e.g. U-Boot) to place printk-compatible messages into
> this buffer and for the kernel to coalesce them with its normal
> messages.
> <snip>

this extended info should be part of the changelog and thus above the
--- marker ...
-mike
