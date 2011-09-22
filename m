Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 906061007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2011 09:16:03 +1000 (EST)
Message-ID: <4E7BC1A9.5050708@freescale.com>
Date: Thu, 22 Sep 2011 18:15:53 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] drivers/tty: don't use the byte channel handle as a
	parameter in ehv_bytechan.c
References: <1316543217-13769-1-git-send-email-timur@freescale.com>
	<20110922230640.GA16981@kroah.com>
In-Reply-To: <20110922230640.GA16981@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-console@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH wrote:
> This patch doesn't apply at all to my tty tree, what was it made
> against?

An internal repository that supposed to be in-sync with the latest and greatest.

What's the URL for your tty-next repo?

-- 
Timur Tabi
Linux kernel developer at Freescale
