Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00F261A2357
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 18:43:24 +1000 (AEST)
Message-ID: <1441615403.8979.3.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: abort cxl_pci_enable_device_hook() if PCI channel
 is offline
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 07 Sep 2015 18:43:23 +1000
In-Reply-To: <1441607471-sup-2948@delenn.ozlabs.ibm.com>
References: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1441583849-sup-2488@delenn.ozlabs.ibm.com> <55ECD8C7.8040600@au1.ibm.com>
 <1441607471-sup-2948@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-07 at 16:33 +1000, Ian Munsie wrote:
> No worries. I've been caught out by something similar in the past when I
> assumed that something like this:
> 
> if (foo)
> 	/*
> 	 * A big long
> 	 * multiline
> 	 * block comment!
> 	 */
> 	 do_something()
> 
> would surely already have curly brackets around it ;-)

You guys can do whatever you like for the cxl code.

cheers
