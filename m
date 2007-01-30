Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org,
 maynardj@us.ibm.com
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 2/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Tue, 30 Jan 2007 05:08:56 +0100
References: <45BE4ED0.5030808@us.ibm.com> <45BE4F55.8070801@us.ibm.com>
In-Reply-To: <45BE4F55.8070801@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701300508.56467.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 29 January 2007 20:47, Maynard Johnson wrote:
>   The code was setting up the debug bus for group 21 when profiling on th=
e=20
> event PPU CYCLES. =A0The debug bus is not actually used by the hardware=20
> performance counters when counting PPU CYCLES. =A0Setting up the debug bus
> for PPU CYCLES causes signal routing conflicts on the debug bus when=20
> profiling PPU cycles and another PPU event. =A0This patch fixes the code =
to=20
> only setup the debug bus to route the performance signals for the non
> PPU CYCLE events.
>=20
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
> Signed-off-by: Carl Love <carll@us.ibm.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Any suggestion for a one-line patch title?
