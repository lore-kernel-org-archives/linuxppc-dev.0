Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217]) by ozlabs.org (Postfix) with ESMTP id 4F225B7CF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Mar 2010 12:49:43 +1100 (EST)
Received: by gxk9 with SMTP id 9so277803gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 18:49:41 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201003120658.55967.roman.fietze@telemotive.de>
References: <201003120658.55967.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 19:49:20 -0600
Message-ID: <fa686aa41003261849k57ba6c4apb2914c49c376964f@mail.gmail.com>
Subject: Re: [PATCH] mpc52xx_lpbfifo: flag DMA irqs as enabled after
	requesting them
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 11, 2010 at 10:58 PM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hello,
>
> This patch avoids unbalanced enable/disable messages for the DMA
> interrupts when running the 5200 platform SCLPC/BestComm driver in DMA
> mode.
>
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>

Applied, thanks.

g.
