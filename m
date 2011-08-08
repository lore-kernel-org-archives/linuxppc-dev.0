Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9FE7B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 06:56:06 +1000 (EST)
Received: from mail40-am1 (localhost.localdomain [127.0.0.1])	by
	mail40-am1-R.bigfish.com (Postfix) with ESMTP id EF98BE681EA	for
	<linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2011 20:55:57 +0000 (UTC)
Message-ID: <4E404D1F.6020503@freescale.com>
Date: Mon, 8 Aug 2011 15:54:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: FW: Ethernet driver WR linux
References: <07ACDFB8ECA8EF47863A613BC01BBB220344E6CD@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <07ACDFB8ECA8EF47863A613BC01BBB220344E6CD@HYD-MKD-MBX02.wipro.com>
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

On 08/08/2011 12:53 AM, smitha.vanga@wipro.com wrote:
>  
> Hi Scott,
> 
> Below is the .dts file. My board is based on mpc8247. Currently using
> FCC1.

This device tree is based on something very short-lived when 82xx
support was first being worked on for 82xx, around 2.6.24 or so.  Please
redo it from scratch based on what is in the current kernel.

-Scott
