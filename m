Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0E4182C01B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 22:32:03 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add dts files for P1021RDB-PC board
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342000689.7459.179.camel@glenn-desktop>
Date: Wed, 11 Jul 2012 07:31:57 -0500
Message-Id: <C14E8E3D-9F60-4242-972D-E9CFD7C4E381@kernel.crashing.org>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <EFC9D38C-4F08-4655-A0DA-9D92A3559C96@kernel.crashing.org>
 <1342000689.7459.179.camel@glenn-desktop>
To: Jiucheng Xu <Jiucheng.Xu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 11, 2012, at 4:58 AM, Jiucheng Xu wrote:

>=20
>=20
> On Tue, 2012-07-10 at 06:48 -0500, Kumar Gala wrote:
>> On Jul 10, 2012, at 3:39 AM, Xu Jiucheng wrote:
>>> ---
>>> arch/powerpc/boot/dts/p1021rdb-pc.dtsi    |  236 =
+++++++++++++++++++++++++++++
>>> arch/powerpc/boot/dts/p1021rdb-pc_32b.dts |   96 ++++++++++++
>>> arch/powerpc/boot/dts/p1021rdb-pc_36b.dts |   96 ++++++++++++
>>> arch/powerpc/boot/dts/p1021rdb.dts        |   96 ------------
>>> arch/powerpc/boot/dts/p1021rdb.dtsi       |  236 =
-----------------------------
>>> arch/powerpc/boot/dts/p1021rdb_36b.dts    |   96 ------------
>>> 6 files changed, 428 insertions(+), 428 deletions(-)
>>> create mode 100644 arch/powerpc/boot/dts/p1021rdb-pc.dtsi
>>> create mode 100644 arch/powerpc/boot/dts/p1021rdb-pc_32b.dts
>>> create mode 100644 arch/powerpc/boot/dts/p1021rdb-pc_36b.dts
>>> delete mode 100644 arch/powerpc/boot/dts/p1021rdb.dts
>>> delete mode 100644 arch/powerpc/boot/dts/p1021rdb.dtsi
>>> delete mode 100644 arch/powerpc/boot/dts/p1021rdb_36b.dts
>>=20
>> Do we really need a 32 & 36 bit device tree for this board?  Isnt the =
memory fixed so why not just have 32b?
>>=20
> I have no idea, 36 bit is already there in the history release of SDK,
> If it is not necessary for upstream, I can resend a new patch without =
36
> bit.
>> Also, why are you removing the dts for the older P1021RDB??
>>=20
>> - k
> This dts for the older P1021RDB was committed by me. I just rename =
these
> files in order to keep uniformity with other platforms, e.g
> "P1020rdb-pc.dtsi  p1020mbg-pc.dtsi". If you think it doesn't matter,
> please ignore this patch.

Sorry, I was thinking there was a different board for P1021RDB (older =
than P1021RDB-PC), like we have for P1020RDB.

> If AMP is a specific application as Timur says, please ignore the AMP
> patch.

- k=
