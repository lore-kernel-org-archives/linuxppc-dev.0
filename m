Return-Path: <richardcochran@gmail.com>
Date: Wed, 16 Jun 2010 07:40:47 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 04/12] phylib: add a way to make PHY time stamps possible.
Message-ID: <20100616054047.GA2887@riccoc20.at.omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
	<AANLkTimhAvu0_WuMCwnCrw9Rbcy6dKxvTlzepJm7ZDdR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimhAvu0_WuMCwnCrw9Rbcy6dKxvTlzepJm7ZDdR@mail.gmail.com>
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 10:33:51AM -0600, Grant Likely wrote:
> > +config NETWORK_PHY_TIMESTAMPING
> Some overhead?  At a brief glance of the series it looks like it could
> add a lot of overhead, but I'm not fully clear on what the full
> process is.  Can you describe how the hardware timestamping works?  I
> could use an overview of what the kernel has to do.

First of all, I want to emphasize that this network stack option is
purely voluntary. Only those people who know that they have a PTP
capable PHY and really want the timestamps will (or should) enable
this option. When it is not enabled, it has no effect at all.

Hardware timestamping is described in

   Documentation/networking/timestamping.txt
   Documentation/networking/timestamping/timestamping.c

The PTP subsystem is described in

   Documentation/ptp/ptp.txt

There really is more to say about the issue than appears in those
documents, but they are a good starting place for discussion.

BTW I am submitting a conference paper on the design on the PTP
subsystem. If you would like to have it, just ask me off-list.

Richard
