Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 48E6EDDDE3
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 12:29:14 +1000 (EST)
Date: Wed, 20 Aug 2008 12:29:13 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: ehrhardt@linux.vnet.ibm.com
Subject: Re: [PATCH 3/4] kvmppc: magic page paravirtualization - guest part
Message-ID: <20080820022912.GJ934@bakeyournoodle.com>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-4-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1219142204-12044-4-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Christian,
	One very minor nit.

On Tue, Aug 19, 2008 at 12:36:43PM +0200, ehrhardt@linux.vnet.ibm.com wrote:
 
> [diffstat]
>  mm/page_alloc.c                |    1

<snip>

>  void kvm_guest_init(void);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -550,6 +550,7 @@
>  				prefetchw(p + 1);
>  			__ClearPageReserved(p);
>  			set_page_count(p, 0);
> +
>  		}
>  
>  		set_page_refcounted(page);

I guess this is a leftover from some debugging but still should be
killed :)

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
