Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 1623DDDF11
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 03:52:20 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1913939ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 02 Jan 2009 08:52:19 -0800 (PST)
Message-ID: <fa686aa40901020852t4f214948n3b4d445f43236e94@mail.gmail.com>
Date: Fri, 2 Jan 2009 09:52:19 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH v2] Update powerpc maintainers
In-Reply-To: <18781.39639.123017.149165@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18781.39639.123017.149165@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 1, 2009 at 9:40 PM, Paul Mackerras <paulus@samba.org> wrote:
> Ben Herrenschmidt is taking over as the primary powerpc architecture
> maintainer.  I'll still be around as his backup/deputy.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Yeah, I *guess* I can follow Ben.  :-P

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> Now with added tree location update goodness!
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ceb32ee..967b0e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2635,13 +2635,13 @@ W:      http://www.hansenpartnership.com/voyager
>  S:     Maintained
>
>  LINUX FOR POWERPC (32-BIT AND 64-BIT)
> -P:     Paul Mackerras
> -M:     paulus@samba.org
>  P:     Benjamin Herrenschmidt
>  M:     benh@kernel.crashing.org
> +P:     Paul Mackerras
> +M:     paulus@samba.org
>  W:     http://www.penguinppc.org/
>  L:     linuxppc-dev@ozlabs.org
> -T:     git kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git
> +T:     git kernel.org:/pub/scm/linux/kernel/git/benh/powerpc.git
>  S:     Supported
>
>  LINUX FOR POWER MACINTOSH
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
