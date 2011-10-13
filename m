Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 93382B71A4
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 02:41:25 +1100 (EST)
Message-ID: <4E970690.3080207@freescale.com>
Date: Thu, 13 Oct 2011 10:41:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH][v2] uio: Support 36-bit physical addresses on 32-bit
 systems
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AE7E@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE7E@saturn3.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 hjk@hansjkoch.de, Jiang Kai-B18973 <B18973@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight wrote:
> Since there is a discriminating field, could a union be used?
> At a guess the type of the address is constrained between
> produces and consumer??

I don't think we need to complicate the code by changing that variable into a
union.  I just a want a short comment added to the structure definition.  I
don't think that's asking a lot.

-- 
Timur Tabi
Linux kernel developer at Freescale
