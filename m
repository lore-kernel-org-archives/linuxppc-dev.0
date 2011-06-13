Return-Path: <stern+4df8bd10@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 84E84B6FBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 00:45:39 +1000 (EST)
Date: Mon, 13 Jun 2011 10:38:56 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Tanya Brokhman <tlinder@codeaurora.org>
Subject: RE: [PATCH] usb:gadget: use min_t() macro instead of min()
In-Reply-To: <03b901cc29c0$6538e970$2faabc50$@org>
Message-ID: <Pine.LNX.4.44L0.1106131036430.1983-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "'open list:FREESCALE USB PER...'" <linuxppc-dev@lists.ozlabs.org>,
	greg@kroah.com, linux-usb@vger.kernel.org,
	'open list' <linux-kernel@vger.kernel.org>, balbi@ti.com,
	linux-arm-msm@vger.kernel.org,
	"'open list:OMAP USB SUPPORT'" <linux-omap@vger.kernel.org>,
	ablay@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Jun 2011, Tanya Brokhman wrote:

> > 
> > On Sun, Jun 12, 2011 at 02:14:46PM +0300, Tatyana Brokhman wrote:
> > > Signed-off-by: Tatyana Brokhman <tlinder@codeaurora.org>
> > 
> > I need a sensible commit log for this. Why do we need to change all
> > min() to min_t() ?
> > 
> 
> Actually, Alan asked me to make this change in one place in dummy_hcd. I
> wasn't aware of the min_t macro before that. So when I searched the code for
> other places I found quite a few and just thought that it would be "nicer"
> to use min_t() instead of min() with casting. 
> So we don't "need" to make this change. Everything works as is. This patch
> only makes the code look nicer, nothing more.
> I can elaborate the above in the commit log if you want.

The change I suggested involved replacing two typecasts with a single 
min_t.  All (or almost all) the places this patch touches currently 
contain only one typecast, so the motivation for changing them is a lot 
weaker.

Alan Stern
