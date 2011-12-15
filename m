Return-Path: <justinmattock@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 00E4F1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2011 04:12:02 +1100 (EST)
Received: by ghrr11 with SMTP id r11so1715820ghr.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 09:11:59 -0800 (PST)
Message-ID: <4EEA2A5A.2050008@gmail.com>
Date: Thu, 15 Dec 2011 09:11:54 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 1/3]arch:powerpc:sysdev:mpic.c Remove extra semicolon.
References: <1321893808-3721-1-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1321893808-3721-1-git-send-email-justinmattock@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, trivial@kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

what would be the status of these? should I resend/rebase to the current 
etc?..

On 11/21/2011 08:43 AM, Justin P. Mattock wrote:
> From: "Justin P. Mattock"<justinmattock@gmail.com>
>
> The patch below removes an extra semicolon.
>
> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: Paul Mackerras<paulus@samba.org>
> ---
>   arch/powerpc/sysdev/mpic.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 8c7e852..b3fa3d7 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -901,7 +901,7 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
>   	if (vold != vnew)
>   		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vnew);
>
> -	return IRQ_SET_MASK_OK_NOCOPY;;
> +	return IRQ_SET_MASK_OK_NOCOPY;
>   }
>
>   void mpic_set_vector(unsigned int virq, unsigned int vector)
