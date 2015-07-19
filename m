Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by lists.ozlabs.org (Postfix) with ESMTP id EE67D1A07F0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 15:22:02 +1000 (AEST)
Message-ID: <55AB33F3.30307@hitachi.com>
Date: Sun, 19 Jul 2015 14:21:55 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, mpe@ellerman.id.au,
 mingo@kernel.org
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] Documentation/features: Add na key to
 arch-support.txt
References: <20150717105139.29162.31467.stgit@thinktux.in.ibm.com>
In-Reply-To: <20150717105139.29162.31467.stgit@thinktux.in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/07/17 19:51, Ananth N Mavinakayanahalli wrote:
> To be used for features we will not support on a particular architecture.
> The git log that adds this needs to provide the justification 'why?'
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> ---
>  Documentation/features/arch-support.txt |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
> index d22a109..f2b272e 100644
> --- a/Documentation/features/arch-support.txt
> +++ b/Documentation/features/arch-support.txt
> @@ -8,4 +8,5 @@ The meaning of entries in the tables is:
>      | ok |  # feature supported by the architecture
>      |TODO|  # feature not yet supported by the architecture
>      | .. |  # feature cannot be supported by the hardware
> +    | na |  # feature will not be supported by the architecture

"will not" sounds like someone's will. I guess it could be "feature is useless/needless
on the architecture".

Thank you,



-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
