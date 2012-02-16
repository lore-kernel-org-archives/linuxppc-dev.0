Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF2D5B6F99
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 04:50:56 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/1] fsldma: ignore end of segments interrupt
Date: Thu, 16 Feb 2012 17:50:47 +0000
Message-ID: <CAOZdJXVccE0GqZU2PvAz3RTh+X9ZYZr-9YufxS+mYWJkhSOGEQ@mail.gmail.com>
References: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 26, 2012 at 2:58 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote=
:
> The mpc8349ea has been observed to generate spurious end of segments
> interrupts despite the fact that they are not enabled by this driver.
> Check for them and ignore them to avoid a kernel error message.

When this happens, are there any other status bits set?  It seems
weird that there are spurious interrupts from an internal block,
especially since it's the same block on all 83xx parts.

I wonder if the EOSI bit just happens to be set when the interrupt
occurs for some other reason.

--=20
Timur Tabi
Linux kernel developer at Freescale=
