Return-Path: <richardcochran@gmail.com>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EDF65B7024
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2012 16:36:55 +1000 (EST)
Received: by wgbgn7 with SMTP id gn7so4136385wgb.21
 for <linuxppc-dev@ozlabs.org>; Mon, 09 Apr 2012 23:36:52 -0700 (PDT)
Date: Tue, 10 Apr 2012 08:36:42 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] gianfar: add missing include
Message-ID: <20120410063641.GA10025@localhost.localdomain>
References: <25411.1334031527@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25411.1334031527@neuling.org>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 10, 2012 at 02:18:47PM +1000, Michael Neuling wrote:
> This is because of a missing include file from:
>   6663628 gianfar: Support the get_ts_info ethtool method.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

I did a poor job testing the non-x86 stuff in this series.  Thanks for
the fix.

Acked-by: Richard Cochran <richardcochran@gmail.com>
