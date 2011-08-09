Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23306B6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 03:56:47 +1000 (EST)
Received: from mail5-tx2 (localhost.localdomain [127.0.0.1])	by
	mail5-tx2-R.bigfish.com (Postfix) with ESMTP id F09391538222	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2011 17:56:37 +0000 (UTC)
Message-ID: <4E4174D1.5060408@freescale.com>
Date: Tue, 9 Aug 2011 12:56:33 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: FW: Ethernet driver WR linux
References: <07ACDFB8ECA8EF47863A613BC01BBB220344EACF@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <07ACDFB8ECA8EF47863A613BC01BBB220344EACF@HYD-MKD-MBX02.wipro.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2011 12:46 AM, smitha.vanga@wipro.com wrote:
> Thank Scott. I am working on a legacy project Which is using 2.6.21
> linux kernel so the device tree is based on that.

Your original e-mail said you were using 2.6.38 ("I have bringup WR
linux 2.6.38 on a custom mpc8247 board").

> Can you let me why the probe error of the driver happens.

No.  There were a lot of fixes and improvements that went into this code
since then, including removing hardcoded assumptions about the hardware
that are described in the device tree with the current binding.  If you
don't want the fixes that come with a newer version, you're on your own
repeating that work.

-Scott
