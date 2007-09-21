Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CECBEDDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 08:32:58 +1000 (EST)
Date: Fri, 21 Sep 2007 23:39:36 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] pcmcia: Convert io_req_t to use kio_addr_t
Message-ID: <20070921233936.2aeb2504@the-village.bc.nu>
In-Reply-To: <20070921221516.GA7926@lixom.net>
References: <20070905142742.GA1760@lixom.net>
	<20070914034854.1658a9cf.akpm@linux-foundation.org>
	<20070921221516.GA7926@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Sep 2007 17:15:16 -0500
Olof Johansson <olof@lixom.net> wrote:

> Convert the io_req_t members to kio_addr_t, to allow use on machines with
> more than 16 bits worth of IO ports (i.e. secondary busses on ppc64, etc).

What about the formatting and field widths ?

ulong would probably be a lot saner than kio_addr_t and yet more type
obfuscation.

Otherwise looks sensible to me
