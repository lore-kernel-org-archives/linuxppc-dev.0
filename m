Return-Path: <glikely@secretlab.ca>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 39691DDE37
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 05:05:07 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so2515394nfd
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 12:05:05 -0700 (PDT)
Message-ID: <fa686aa40709281205m6a011859yc7cbfd0f7bb13d5b@mail.gmail.com>
Date: Fri, 28 Sep 2007 13:05:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Subject: Re: [PATCH 05/18] Add PowerPC Xilinx Virtex entry to maintainers
In-Reply-To: <20070928181627.18608.29878.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181627.18608.29878.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> Paul, is this okay by you?  Josh has already okayed it.

Specifically, I'll collect the virtex changes and ask Josh to pull
them from me before requesting a pull from you.

Cheers,
g.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f80068..ea4ff15 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2304,6 +2304,13 @@ L:       linuxppc-embedded@ozlabs.org
>  T:     git kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc.git
>  S:     Maintained
>
> +LINUX FOR POWERPC EMBEDDED XILINX VIRTEX
> +P:     Grant Likely
> +M:     grant.likely@secretlab.ca
> +W:     http://www.secretlab.ca/
> +L:     linuxppc-embedded@ozlabs.org
> +S:     Maintained
> +
>  LINUX FOR POWERPC BOOT CODE
>  P:     Tom Rini
>  M:     trini@kernel.crashing.org
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
