Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EFC01A013A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 03:54:50 +1000 (EST)
Date: Mon, 25 Aug 2014 13:54:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 4/5] kexec: Add IND_FLAGS macro
Message-ID: <20140825175400.GG14379@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <c2d710e956591376b08bcbc3f904efd9b0c8b912.1408731991.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c2d710e956591376b08bcbc3f904efd9b0c8b912.1408731991.git.geoff@infradead.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 22, 2014 at 06:39:47PM +0000, Geoff Levand wrote:
> Add a new kexec preprocessor macro IND_FLAGS, which is the bitwise OR of
> all the possible kexec IND_ kimage_entry indirection flags.
> 
> Having this macro allows for simplified code in the prosessing of the
> kexec kimage_entry items.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  include/linux/kexec.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 8c628ca..a4758f9 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -10,6 +10,7 @@
>  #define IND_INDIRECTION  (1 << IND_INDIRECTION_BIT)
>  #define IND_DONE         (1 << IND_DONE_BIT)
>  #define IND_SOURCE       (1 << IND_SOURCE_BIT)
> +#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
>  
>  #if !defined(__ASSEMBLY__)
>  
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
