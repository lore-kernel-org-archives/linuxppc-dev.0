Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABDE8B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 06:21:55 +1100 (EST)
Date: Wed, 27 Oct 2010 20:21:01 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] drivers/char/hvc_console.c: reduce max idle timeout
Message-ID: <20101027202101.226085c1@lxorguk.ukuu.org.uk>
In-Reply-To: <201010271659.o9RGxrMc009847@farm-0002.internal.tilera.com>
References: <201010271659.o9RGxrMc009847@farm-0002.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Oct 2010 12:54:27 -0400
Chris Metcalf <cmetcalf@tilera.com> wrote:

> The tile architecture uses this framework for our serial console,

That may be a mistake unless your console is genuinely only capable of
polled input.

Alan
