Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F3C98B72A5
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 08:59:47 +1100 (EST)
Message-ID: <4ED7F8CE.10801@freescale.com>
Date: Thu, 1 Dec 2011 15:59:42 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] i2c-mpc: use the cell-index property to enumerate the
 I2C adapters
References: <1322760781-31226-1-git-send-email-timur@freescale.com>
 <4ED7CA64.2080503@freescale.com> <4ED7E975.6090704@freescale.com>
 <4ED7F1AE.70806@freescale.com> <4ED7F5AA.2040909@freescale.com>
 <4ED7F72F.7050405@freescale.com>
In-Reply-To: <4ED7F72F.7050405@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Ideally we would have a field in struct device_node that points to
> struct device.

I don't think there's a single place in the code where the connection between the device and device_node is made.  In fact, I think dev->of_node needs to be manually initialized by the driver during the OF probe.

-- 
Timur Tabi
Linux kernel developer at Freescale
