Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0148B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Aug 2011 02:53:01 +1000 (EST)
Subject: Re: [RFC 4/4] [powerpc] Implement a p1010rdb clock source.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E3D4875.30707@pengutronix.de>
Date: Sat, 6 Aug 2011 11:52:45 -0500
Message-Id: <39414D86-7822-4B92-B005-351890A2A167@kernel.crashing.org>
References: <1312603504-30282-1-git-send-email-holt@sgi.com>
	<1312603504-30282-5-git-send-email-holt@sgi.com>
	<4E3D4875.30707@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Netdev <netdev@vger.kernel.org>, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	"linuxppc-dev@lists.ozlabs.org Development" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 6, 2011, at 8:58 AM, Marc Kleine-Budde wrote:

> On 08/06/2011 06:05 AM, Robin Holt wrote:
>> flexcan driver needs the clk_get, clk_get_rate, etc functions
>> to work.  This patch provides the minimum functionality.
>=20
> This patch has to go via the powerpc git tree. Added
> linuxppc-dev@lists.ozlabs.org on CC.
>=20
>> Signed-off-by: Robin Holt <holt@sgi.com>
>> To: Marc Kleine-Budde <mkl@pengutronix.de>
>> To: Wolfgang Grandegger <wg@grandegger.com>
>> To: U Bhaskar-B22300 <B22300@freescale.com>
>> Cc: socketcan-core@lists.berlios.de
>> Cc: netdev@vger.kernel.org
>> ---
>> arch/powerpc/platforms/85xx/p1010rdb.c |   78 =
++++++++++++++++++++++++++++++++
>> 1 files changed, 78 insertions(+), 0 deletions(-)

NAK.

This doesn't look right at all.  We should be doing something based on =
the device tree node that isn't board specific.

I believe Bhaskar has a version of flexcan support that he's been =
working on cleanup up for upstream.

- k=
