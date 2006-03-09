Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 5A02A679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 00:33:45 +1100 (EST)
Message-ID: <44102EB3.2000301@ru.mvista.com>
Date: Thu, 09 Mar 2006 16:33:39 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [Patch] Fix compile error for ML300/403
References: <528646bc0603081507t24c7e2f5u8e2823931200a857@mail.gmail.com>
In-Reply-To: <528646bc0603081507t24c7e2f5u8e2823931200a857@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> Fix compile error due to changes in ppc_sys.c.  This is needed in the
> powerpc.git tree
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> 
> ---
> commit 75ec8a6ff8410c30f459e5e1c924ce811f8b1e25
> tree 87f29c44458d2966bf208f9ea25432b26faa2eb5
> parent 126dddf2535520cbeafb7069ce092b80beb8558a
> author Grant Likely <grant.likely@secretlab.ca> Wed, 08 Mar 2006 16:03:56 -0700
> committer <grant@weasley-twins.(none)> Wed, 08 Mar 2006 16:03:56 -0700
> 
>  arch/ppc/platforms/4xx/virtex.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virtex.h
> index 2a2a65c..4d893ef 100644
> --- a/arch/ppc/platforms/4xx/virtex.h
> +++ b/arch/ppc/platforms/4xx/virtex.h
> @@ -27,7 +27,7 @@
>  /* Device type enumeration for platform bus definitions */
>  #ifndef __ASSEMBLY__
>  enum ppc_sys_devices {
> -       VIRTEX_UART, VIRTEX_FB,
> +       VIRTEX_UART, VIRTEX_FB, NUM_PPC_SYS_DEVS,

AFAIK there is no VIRTEX_FB in the powerpc.git tree yet.
Otherwise I confirm that adding NUM_PPC_SYS_DEVS is necessary.

Thanks,
Andrei

>  };
>  #endif
> 
> 
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> (403) 399-0195
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
