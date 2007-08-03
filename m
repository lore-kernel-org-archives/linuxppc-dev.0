Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9166DDDE21
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 02:27:10 +1000 (EST)
Message-ID: <46B357D3.1040608@ru.mvista.com>
Date: Fri, 03 Aug 2007 20:29:07 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
References: <20070730150648.GA5005@ru.mvista.com>	<20070801020836.GB31391@localhost.localdomain>	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
In-Reply-To: <20070801054751.GM31391@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Duh, forgot to attach the actual patch.  Here it is:

> Index: working-2.6/Documentation/powerpc/booting-without-of.txt
> ===================================================================
> --- working-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-07-30 17:07:14.000000000 +1000
> +++ working-2.6/Documentation/powerpc/booting-without-of.txt	2007-07-30 17:07:14.000000000 +1000
> @@ -1757,45 +1757,23 @@ platforms are moved over to use the flat
>  		};
>  	};
>  
> -    j) Flash chip nodes
> +   j) CFI or JEDEC memory-mapped NOR flash
>  
>      Flash chips (Memory Technology Devices) are often used for solid state
>      file systems on embedded devices.
>  
> -    Required properties:
> +     - compatible : should contain the specific model of flash chip(s) used
> +       followed by either "cfi-flash" or "jedec-flash"

    Duh, have nearly forgotten to complain about "-flash" suffix.  Isn't it 
superfluous?

WBR, Sergei
