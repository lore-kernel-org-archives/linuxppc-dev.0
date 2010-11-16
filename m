Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id AD33DB712F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 22:33:27 +1100 (EST)
Received: by wwb24 with SMTP id 24so99961wwb.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 03:33:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1289809300-4038-1-git-send-email-abogani@texware.it>
References: <1289809300-4038-1-git-send-email-abogani@texware.it>
Date: Tue, 16 Nov 2010 06:33:24 -0500
Message-ID: <AANLkTim15YqYThqBw7=GLGbthXdQ836BdWamA4ncSP30@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Update a comment
From: Josh Boyer <jwboyer@gmail.com>
To: Alessio Igor Bogani <abogani@texware.it>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Tim Bird <tim.bird@am.sony.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 3:21 AM, Alessio Igor Bogani <abogani@texware.it> w=
rote:
> The commit 5e3d20a remove bkl from startup code so setup_arch() it isn't =
called
> with bkl held anymore. Update the comment on top of that function.
>
> This work was supported by a hardware donation from the CE Linux Forum.

You should make sure to send powerpc patches to linuxppc-dev.

>
> Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
> ---
> =A0arch/powerpc/kernel/setup_64.c | =A0 =A05 ++---
> =A01 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c
> index 2a178b0..71f44e5 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -497,9 +497,8 @@ static void __init emergency_stack_init(void)
> =A0}
>
> =A0/*
> - * Called into from start_kernel, after lock_kernel has been called.
> - * Initializes bootmem, which is unsed to manage page allocation until
> - * mem_init is called.
> + * Called into from start_kernel this initializes bootmem, which is unse=
d
> + * to manage page allocation until mem_init is called.

You might as well fix the typo while you're there.  unsed->used

josh
