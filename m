Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 6807FDDFCA
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 04:52:27 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 8 Oct 2007 11:52:25 -0700
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [linux-usb-devel] [PATCH] USB: Add frame_no big endian OHCI quirk
Message-ID: <20071008185225.GB2900@xyzzy.farnsworth.org>
References: <20071008165436.GA19653@ru.mvista.com>
	<20071008184140.GA30470@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071008184140.GA30470@ru.mvista.com>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 08, 2007 at 10:41:40PM +0400, Valentine Barshak wrote:
> Add OHCI big endian frame_no quirk.
> The frame_no value stored in the HCCA is a 16 bit field 
> at a specific offset, but since not all CPUs can do 16-bit
> memory accesses it's used as a 32 bit field.
> And that's why big-endian OHCI will shift 16 bits,
> unless the spec is not followed. Currently there's one MPC52xx
> platform that doesn't need the shift. This case is hanled
> using big endian frame_no quirk.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Acked-by: Dale Farnsworth <dale@farnsworth.org>
