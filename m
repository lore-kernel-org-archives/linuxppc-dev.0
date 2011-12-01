Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D46D4B6F67
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 09:05:50 +1100 (EST)
Message-ID: <4ED7FA38.6030606@freescale.com>
Date: Thu, 1 Dec 2011 16:05:44 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] i2c-mpc: use the cell-index property to enumerate the
 I2C adapters
References: <1322760781-31226-1-git-send-email-timur@freescale.com>
 <4ED7CA64.2080503@freescale.com> <4ED7E975.6090704@freescale.com>
 <4ED7F1AE.70806@freescale.com> <4ED7F5AA.2040909@freescale.com>
 <4ED7F72F.7050405@freescale.com> <4ED7F8CE.10801@freescale.com>
In-Reply-To: <4ED7F8CE.10801@freescale.com>
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

On 12/01/2011 03:59 PM, Timur Tabi wrote:
> Scott Wood wrote:
>> Ideally we would have a field in struct device_node that points to
>> struct device.
> 
> I don't think there's a single place in the code where the connection
> between the device and device_node is made.  In fact, I think
> dev->of_node needs to be manually initialized by the driver during
> the OF probe.

The i2c core does this.

Does of_find_i2c_device_by_node() do what you want?

-Scott
