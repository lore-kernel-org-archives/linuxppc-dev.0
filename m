Return-Path: <timur@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 816FA1A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 15:40:17 +1100 (AEDT)
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
 [209.85.213.171])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: timur@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FED713F381
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 04:40:11 +0000 (UTC)
Received: by igcto18 with SMTP id to18so49973289igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Dec 2015 20:40:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1449144546-25438-1-git-send-email-madalin.bucur@freescale.com>
References: <1449144546-25438-1-git-send-email-madalin.bucur@freescale.com>
Date: Fri, 4 Dec 2015 22:40:11 -0600
Message-ID: <CAOZdJXU6CJe-9NsxhnS6ECfXd=KrY_6e+MJZZbJOa8+p5-4jxA@mail.gmail.com>
Subject: Re: [net-next v5 0/8] dpaa_eth: Add the Freescale DPAA Ethernet driver
From: Timur Tabi <timur@codeaurora.org>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 David Miller <davem@davemloft.net>, Scott Wood <scottwood@freescale.com>,
 igal.liberman@freescale.com, ppc@mindchasers.com,
 Joe Perches <joe@perches.com>, pebolle@tiscali.nl,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 3, 2015 at 6:08 AM,  <> wrote:
> From: Madalin Bucur <madalin.bucur@freescale.com>
>
> This patch series adds the Ethernet driver for the Freescale
> QorIQ Data Path Acceleration Architecture (DPAA).

Please fix your git-send-email configuration, so that your emails are
formatted properly.  This is the From: header:

        From: <>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
