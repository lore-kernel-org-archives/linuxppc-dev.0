Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 62C89DE242
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 00:16:07 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so522231anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Apr 2008 06:16:01 -0700 (PDT)
Message-ID: <fa686aa40804010616v4d6a2c8at5d3be8c32f316494@mail.gmail.com>
Date: Tue, 1 Apr 2008 07:16:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2] powerpc: Describe memory-mapped RAM&ROM chips OF
	bindings
In-Reply-To: <200803311839.10519.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200803311839.10519.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2008 at 10:39 AM, Laurent Pinchart
<laurentp@cse-semaphore.com> wrote:
>
>  Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
>  ---
>   Documentation/powerpc/booting-without-of.txt |   13 ++++++++++++-
>   1 files changed, 12 insertions(+), 1 deletions(-)
>
>  diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
>  index 7b4e8a7..3e1963b 100644
>  --- a/Documentation/powerpc/booting-without-of.txt
>  +++ b/Documentation/powerpc/booting-without-of.txt
>  @@ -57,7 +57,8 @@ Table of Contents
>        n) 4xx/Axon EMAC ethernet nodes
>        o) Xilinx IP cores
>        p) Freescale Synchronous Serial Interface
>  -         q) USB EHCI controllers
>  +      q) USB EHCI controllers
>  +      r) Memory-mapped RAM & ROM
>
>    VII - Specifying interrupt information for devices
>      1) interrupts property
>  @@ -2816,6 +2817,16 @@ platforms are moved over to use the flattened-device-tree model.
>                    big-endian;
>            };
>
>  +   r) Memory-mapped RAM & ROM
>  +
>  +    Dedicated RAM and ROM chips are often used as storage for temporary or
>  +    permanent data in embedded devices. Possible usage include non-volatile
>  +    storage in battery-backed SRAM, semi-permanent storage in dedicated SRAM
>  +    to preserve data accross reboots and firmware storage in dedicated ROM.
>  +
>  +     - name : should be either "ram" or "rom"
>  +     - reg : Address range of the RAM/ROM chip
>  +

No compatible prop?  How does the OS know what the node is to be used for?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
