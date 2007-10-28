Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.239.214.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9865CDDF0C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 00:51:00 +1100 (EST)
Date: Sun, 28 Oct 2007 14:44:14 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] pcmcia: Convert io_req_t to use unsigned int
Message-ID: <20071028134414.GF26943@isilmar.linta.de>
References: <20070905142742.GA1760@lixom.net>
	<20070914034854.1658a9cf.akpm@linux-foundation.org>
	<20070921221516.GA7926@lixom.net>
	<20070921233936.2aeb2504@the-village.bc.nu>
	<20070922062551.GE10625@parisc-linux.org>
	<20070922091303.GA12525@lst.de> <20071019201720.GA13234@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071019201720.GA13234@lixom.net>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 03:17:20PM -0500, Olof Johansson wrote:
> Convert the io_req_t members to unsigned int, to allow use on machines
> with more than 16 bits worth of IO ports (i.e. secondary busses on
> ppc64, etc).

Agreed, though I'd prefer if we got rid of kio_addr_t at the same time, and
convert its users to unsigned int as well -- as was pointed out earlier in
this thread, there's no known usage of IO ports larger than 32 bits.

	Dominik
