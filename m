Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD057DE1D9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 09:22:01 +1100 (EST)
Date: Mon, 28 Jan 2008 16:19:29 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] 83xx: Clean up / convert mpc83xx board DTS files to v1
	format.
In-Reply-To: <1201554576-32653-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <Pine.LNX.4.64.0801281619040.28029@blarg.am.freescale.net>
References: <54AD0075-E36B-4A95-BFD9-C750E590513F@kernel.crashing.org>
	<1201554576-32653-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jan 2008, Paul Gortmaker wrote:

> This patch converts the remaining 83xx boards to the dts-v1 format.
> This includes the mpc8313_rdb, mpc832x_mds, mpc8323_rdb, mpc8349emitx,
> mpc8349emitxgp and the mpc836x_mds.
>
> The mpc8315_rdb mpc834x_mds, mpc837[789]_*, and sbc8349 were already
> dts-v1 and only undergo minor changes for the sake of formatting
> consistency across the whole group of boards; i.e.  the idea being
> that you can do a "diff -u board_A.dts board_B.dts" and see something
> meaningful.
>
> The general rule I've applied is that entries for values normally
> parsed by humans are left in decimal (i.e. IRQ, cache size, clock
> rates, basic counts and indexes) and all other data (i.e. reg and
> ranges, IRQ flags etc.) remain in hex.
>
> I've used dtc to confirm that the output prior to this changeset
> matches the output after this changeset is applied for all boards.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/boot/dts/mpc8313erdb.dts    |  152 +++++++++---------
>  arch/powerpc/boot/dts/mpc8315erdb.dts    |  100 ++++++------
>  arch/powerpc/boot/dts/mpc832x_mds.dts    |  252 +++++++++++++++--------------
>  arch/powerpc/boot/dts/mpc832x_rdb.dts    |  154 +++++++++---------
>  arch/powerpc/boot/dts/mpc8349emitx.dts   |  155 +++++++++---------
>  arch/powerpc/boot/dts/mpc8349emitxgp.dts |  109 +++++++------
>  arch/powerpc/boot/dts/mpc834x_mds.dts    |   36 ++--
>  arch/powerpc/boot/dts/mpc836x_mds.dts    |  260 +++++++++++++++---------------
>  arch/powerpc/boot/dts/mpc8377_mds.dts    |  138 ++++++++--------
>  arch/powerpc/boot/dts/mpc8377_rdb.dts    |  102 ++++++------
>  arch/powerpc/boot/dts/mpc8378_mds.dts    |  130 ++++++++--------
>  arch/powerpc/boot/dts/mpc8378_rdb.dts    |   94 ++++++------
>  arch/powerpc/boot/dts/mpc8379_mds.dts    |  146 +++++++++---------
>  arch/powerpc/boot/dts/mpc8379_rdb.dts    |  112 +++++++-------
>  arch/powerpc/boot/dts/sbc8349.dts        |   44 +++---
>  15 files changed, 999 insertions(+), 985 deletions(-)
>

applied.  Checkout for whitespace in the future (sbc8349.dts)

- k
