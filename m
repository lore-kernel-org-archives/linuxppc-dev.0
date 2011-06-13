Return-Path: <stern+4df8bd10@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id BAED0B6FBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 05:03:45 +1000 (EST)
Date: Mon, 13 Jun 2011 15:03:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Tanya Brokhman <tlinder@codeaurora.org>
Subject: RE: [PATCH] usb:gadget: use min_t() macro instead of min()
In-Reply-To: <03db01cc29f4$d472bcb0$7d583610$@org>
Message-ID: <Pine.LNX.4.44L0.1106131503040.1983-100000@iolanthe.rowland.org>
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
> > The change I suggested involved replacing two typecasts with a single
> > min_t.  All (or almost all) the places this patch touches currently
> > contain only one typecast, so the motivation for changing them is a lot
> > weaker.
> > 
> You're right. So what's the final call on this one? Do you think it can be
> merged or you prefer not change anything? I personally think the code looks
> nicer using min_t instead of min with casting but that's just my opinion and
> of course there are arguments against this patch.

I don't care either way.  It's up to you and Felipe.

Alan Stern
