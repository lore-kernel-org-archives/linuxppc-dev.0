Return-Path: <magnus.damm@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 92AEA680C2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 21:51:17 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id i1so110384nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 01 Sep 2005 04:51:16 -0700 (PDT)
Message-ID: <aec7e5c305090104449079fc3@mail.gmail.com>
Date: Thu, 1 Sep 2005 20:44:47 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
In-Reply-To: <20050901085319.GB6285@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050830024840.GA5381@dmt.cnet>
	<20050901085319.GB6285@isilmar.linta.de>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

Nice to see that this driver gets forward ported to 2.6. I originally
wrote it for pcmcia-cs, but it made its way into 2.4 after a while.
Thanks to all the people who added code and fixes.

I'm not sure how the current Linux pcmcia layer works, and I am not
involved in powerpc land anymore so I have no comments on the porting
work or the driver itself.

On 9/1/05, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> On Mon, Aug 29, 2005 at 11:48:40PM -0300, Marcelo Tosatti wrote:
> > Russell: The driver is using pccard_nonstatic_ops for card window
> > management, even though the driver its marked SS_STATIC_MAP (using
> > mem->static_map).
>=20
> This is obviously broken. Where does it fail if pccard_static_ops is used=
?

I remember it was interesting to write the driver for pcmcia-cs. This
was because the mpc8xx socket hardware did not implement per-window
offsets, and pcmcia-cs required that. So a wild guess is that this
static/notstatic thing is related to that.

/ magnus
