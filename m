Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id B82C2B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 22:40:43 +1000 (EST)
Date: Tue, 9 Aug 2011 07:40:42 -0500
From: Robin Holt <holt@sgi.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC 4/4] [powerpc] Add flexcan device support for p1010rdb.
Message-ID: <20110809124042.GR4926@sgi.com>
References: <1312869313-22434-1-git-send-email-holt@sgi.com>
	<1312869313-22434-5-git-send-email-holt@sgi.com>
	<4E41291B.3020001@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E41291B.3020001@pengutronix.de>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2011 at 02:33:31PM +0200, Marc Kleine-Budde wrote:
> On 08/09/2011 07:55 AM, Robin Holt wrote:
> > I added a clock source for the p1010rdb so the flexcan driver
> > could find its clock frequency.
> > 
> > Signed-off-by: Robin Holt <holt@sgi.com>
> > To: Marc Kleine-Budde <mkl@pengutronix.de>,
> > To: Wolfgang Grandegger <wg@grandegger.com>,
> > To: U Bhaskar-B22300 <B22300@freescale.com>
> > Cc: socketcan-core@lists.berlios.de,
> > Cc: netdev@vger.kernel.org,
> > Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> 
> After fixing Wolfgangs remarks add by Acked-by, for what it's worth in
> the ppc-world :)

Does that go for the other two patches in the series you have not
commented on in many revs as well?

Robin
