Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C29BA1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 08:48:55 +1100 (AEDT)
Date: Mon, 15 Dec 2014 13:48:53 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Tessier <michael.tessier@axiontech.ca>
Subject: Re: PROBLEM: USB isochronous urb leak on EHCI driver
Message-ID: <20141215214853.GA16425@kroah.com>
References: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 15, 2014 at 08:53:20PM +0000, Michael Tessier wrote:
> <5>Linux version 2.6.31-770-g0e46b52-0897 (michael.tessier@vsvr-compile-01.pocatec.com) (gcc version 4.1.2) #12 PREEMPT Mon Nov 24 18:34:19 EST 2014

That is a _very_ old and obsolete kernel version, you need to get
support from the company that is forcing you to stay on that version, as
you are paying them for this.

There is nothing the community can do with a kernel version like this,
sorry.

best of luck,

greg k-h
