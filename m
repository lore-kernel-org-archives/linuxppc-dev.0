Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH][v0] RTC driver(Linux) for PT7C4338 chip.
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1287994138-31771-1-git-send-email-Priyanka.Jain@freescale.com>
Date: Tue, 26 Oct 2010 02:52:10 -0500
Message-Id: <D236C98D-7F58-4999-9190-6BC2551B682F@kernel.crashing.org>
References: <1287994138-31771-1-git-send-email-Priyanka.Jain@freescale.com>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 25, 2010, at 3:08 AM, Priyanka Jain wrote:

> PT7C4338 chip is manufactured by Pericom Technology Inc.
> It is a serial real-time clock which provides:
> 1)Low-power clock/calendar.
> 2)Programmable square-wave output.
> It has 56 bytes of nonvolatile RAM.
>=20
> Freescale P1010RDB uses PT7C4338 as RTC.

This line shouldn't be in the commit message

>=20
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> ---
> Based of unified git(next branch) for P1010 RDB.
> drivers/rtc/Kconfig        |    9 ++
> drivers/rtc/Makefile       |    1 +
> drivers/rtc/rtc-pt7c4338.c |  215 =
++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 225 insertions(+), 0 deletions(-)
> create mode 100644 drivers/rtc/rtc-pt7c4338.c

This should be CC'd to the RTC list and maintainer.

- k=
