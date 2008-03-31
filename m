Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 54FF4DE45A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 03:07:19 +1000 (EST)
Message-ID: <47F11A19.4050305@ru.mvista.com>
Date: Mon, 31 Mar 2008 21:06:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2] powerpc: Describe memory-mapped RAM&ROM chips OF
	bindings
References: <200803311839.10519.laurentp@cse-semaphore.com>
In-Reply-To: <200803311839.10519.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Laurent Pinchart wrote:

> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 7b4e8a7..3e1963b 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -57,7 +57,8 @@ Table of Contents
>        n) 4xx/Axon EMAC ethernet nodes
>        o) Xilinx IP cores
>        p) Freescale Synchronous Serial Interface
> -	  q) USB EHCI controllers
> +      q) USB EHCI controllers
> +      r) Memory-mapped RAM & ROM

    Memory-mapped RA/RO Memory again? Should better drop this. :-)

WBR, Sergei
