Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [72.1.168.231])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "usmamail.tilera.com",
	Issuer "Go Daddy Secure Certification Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10D99B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 06:46:35 +1100 (EST)
Message-ID: <4CC88193.8020607@tilera.com>
Date: Wed, 27 Oct 2010 15:46:27 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/char/hvc_console.c: reduce max idle timeout
References: <201010271659.o9RGxrMc009847@farm-0002.internal.tilera.com>
	<20101027202101.226085c1@lxorguk.ukuu.org.uk>
In-Reply-To: <20101027202101.226085c1@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/27/2010 3:21 PM, Alan Cox wrote:
> On Wed, 27 Oct 2010 12:54:27 -0400 Chris Metcalf <cmetcalf@tilera.com> wrote:
>> The tile architecture uses this framework for our serial console,
> That may be a mistake unless your console is genuinely only capable of
> polled input.

The console is in fact interrupt-driven within the hypervisor, and data is
buffered there.  However, the current hypervisor console API is only
"write" and "read".  We have a bugzilla to add console interrupts to the
hypervisor API and use them from Linux, but we haven't done it yet.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
