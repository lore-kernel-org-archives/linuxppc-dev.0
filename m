Date: Thu, 8 Jul 2004 16:07:13 -0700
From: Greg KH <greg@kroah.com>
To: sensors@Stimpy.netroedge.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] PPC4xx IIC driver: 0-length transactions bit-banging implementation
Message-ID: <20040708230713.GF20431@kroah.com>
References: <20040622185116.GA4146@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040622185116.GA4146@gate.ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 22, 2004 at 11:51:16AM -0700, Eugene Surovegin wrote:
> Greg,
>
> IBM PPC 4xx i2c controller doesn't support 0-length transactions (e.g. used by
> SMBUS_QUICK). This patch implements bit-banging emulation for such requests and
> removes temporary kludge added earlier.
>
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
>
> Please, apply.

Applied, thanks.

greg k-h

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
