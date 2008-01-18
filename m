Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 6B6D0DDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:36:00 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so195114anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 16:35:59 -0800 (PST)
Message-ID: <fa686aa40801171635m1531ae35t63aac14d6ef46d78@mail.gmail.com>
Date: Thu, 17 Jan 2008 17:35:59 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [Add mpc5121 support PATCHES v3 0/8]
In-Reply-To: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/17/08, John Rigby <jrigby@freescale.com> wrote:
> This is a new improved set of patches based on the
> comments that I received in response to the previous set.
>
> Changes since v2:
>
> 1/8 Add-IPIC-config-option.patch
> 2/8 Add-mpc512x-ipic-support.patch
>     No changes.  These two are in galak's queue for submission.
>
> 3/8 Basic-Freescale-MPC512x-support.patch
>     Added missing of_put_node as pointed out by Stephen Rothwell
>     Added Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> 4/8 Device-tree-for-MPC5121-ADS.patch
>     Made changes suggested by Grant Likely
>
> 5/8 Separate-MPC52xx-PSC-FIFO-registers-from-rest-of-PSC.patch
> 6/8 Cleanup-checkpatch.pl-problems-in-mpc52xx_uart.c.patch
>     No changes.  Grant is picking up these patches
>
> 7/8 Factor-out-52xx-dependencies-from-52xx-psc-driver.patch
>     No changes.  No comments received.  Too ugly to comment?

No; I'm just percolating on these two.  I'll probably pick these up,
but I need to look at them in greater detail first.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
