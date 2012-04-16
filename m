Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C968FB700D
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 04:02:32 +1000 (EST)
Message-ID: <4F8C5EB0.1070500@freescale.com>
Date: Mon, 16 Apr 2012 13:02:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anthony Foiani <tkil@scrye.com>
Subject: Re: PPC / USB: kernel hangs in warm boot on 8513 in fsl-ehci
References: <gsjg4i8sh.fsf@dworkin.scrye.com>
In-Reply-To: <gsjg4i8sh.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/15/2012 11:45 PM, Anthony Foiani wrote:
> But I'm still seeing the hang.  (And I realize, now that I'm not head
> down on the project, that the snooping fixes are probably irrelevant
> for a single-core system like mine.)

Snooping is still relevant on single-core systems for DMA.

-Scott
