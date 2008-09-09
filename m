Return-Path: <timur.tabi@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id 3120DDE070
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 04:25:55 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so2149404wra.1
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Sep 2008 11:25:54 -0700 (PDT)
Message-ID: <ed82fe3e0809091125y77973b83vce52e044f329030e@mail.gmail.com>
Date: Tue, 9 Sep 2008 13:25:54 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] Pass actual dev ptr to dma_* in ucc and cpm_uart serial
In-Reply-To: <48C58359.5060208@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1220901653-12812-1-git-send-email-becky.bruce@freescale.com>
	<48C58359.5060208@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 8, 2008 at 2:56 PM, Scott Wood <scottwood@freescale.com> wrote:

> This patch doesn't change that for cpm2, since port.dev is never
> initialized. :-P

I don't initialize port->dev in the UCC UART driver, but it's still
non-zero, so why isn't it initialized in the CPM UART driver?

(P.S. Becky - please CC: me on any UCC UART or QE LIB patches)

-- 
Timur Tabi
Linux kernel developer at Freescale
