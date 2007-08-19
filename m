Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A109DDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Aug 2007 12:42:51 +1000 (EST)
Date: Sat, 18 Aug 2007 20:57:52 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
Message-ID: <20070818205752.049d2bc6@vader.jdub.homelinux.org>
In-Reply-To: <46C79E33.8090600@dlasys.net>
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<87vebryfrv.fsf@sleipner.barco.com> <46C79E33.8090600@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 18 Aug 2007 21:34:43 -0400
"David H. Lynch Jr." <dhlii@dlasys.net> wrote:

> arch/boot/simple/embed_config.c jusst seems to be a random collection
> of board specific code anyway.
> A giant case statement implimented with #ifdef's. It is just
> screaming to be done some better way.

You mean like a device tree?  ;)

josh
