Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8845A2C010B
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 09:33:33 +1000 (EST)
Received: from mail69-co1 (localhost [127.0.0.1])	by mail69-co1-R.bigfish.com
 (Postfix) with ESMTP id 4BE2C680072	for <linuxppc-dev@ozlabs.org>;
 Tue, 10 Sep 2013 23:33:30 +0000 (UTC)
Received: from CO1EHSMHS013.bigfish.com (unknown [10.243.78.244])	by
 mail69-co1.bigfish.com (Postfix) with ESMTP id 1F741AC0052	for
 <linuxppc-dev@ozlabs.org>; Tue, 10 Sep 2013 23:33:28 +0000 (UTC)
Message-ID: <1378856005.12204.372.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: DTS - re-organize the SPI partitions
 property
From: Scott Wood <scottwood@freescale.com>
To: Mingkai Hu <Mingkai.Hu@freescale.com>
Date: Tue, 10 Sep 2013 18:33:25 -0500
In-Reply-To: <1378454743-17637-1-git-send-email-Mingkai.Hu@freescale.com>
References: <1378454743-17637-1-git-send-email-Mingkai.Hu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-06 at 16:05 +0800, Mingkai Hu wrote:
> Re-organize the SPI partitions and use the same SPI flash memory
> map for most of the platforms which have 16MB SPI flash mounted.
[snip]
> Based on 'next' branch on git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> 
>  arch/powerpc/boot/dts/bsc9131rdb.dtsi  | 35 ++++++++++++-----------------
>  arch/powerpc/boot/dts/c293pcie.dts     | 35 ++++++++++++-----------------
>  arch/powerpc/boot/dts/mpc8536ds.dtsi   | 12 +++++-----
>  arch/powerpc/boot/dts/p1010rdb.dtsi    | 40 ++++++++++++----------------------
>  arch/powerpc/boot/dts/p1020rdb-pc.dtsi | 24 +++++---------------
>  arch/powerpc/boot/dts/p1020rdb-pd.dts  | 34 ++++++++++++-----------------
>  arch/powerpc/boot/dts/p1020rdb.dtsi    | 23 ++++---------------
>  arch/powerpc/boot/dts/p1021mds.dts     | 17 +++++++--------
>  arch/powerpc/boot/dts/p1021rdb-pc.dtsi | 32 +++++++++------------------
>  arch/powerpc/boot/dts/p1022ds.dtsi     | 21 +++++++++---------
>  arch/powerpc/boot/dts/p1023rds.dts     | 10 ++-------
>  arch/powerpc/boot/dts/p1024rdb.dtsi    | 40 ++++++++++++----------------------
>  arch/powerpc/boot/dts/p1025rdb.dtsi    | 23 +++++--------------
>  arch/powerpc/boot/dts/p2020rdb-pc.dtsi | 40 ++++++++++++----------------------
>  arch/powerpc/boot/dts/p2020rdb.dts     | 38 ++++++++++----------------------
>  arch/powerpc/boot/dts/p2041rdb.dts     | 12 +++++-----
>  arch/powerpc/boot/dts/p3041ds.dts      | 12 +++++-----
>  arch/powerpc/boot/dts/p4080ds.dts      | 12 +++++-----
>  arch/powerpc/boot/dts/p5020ds.dts      | 12 +++++-----
>  arch/powerpc/boot/dts/p5040ds.dts      | 13 ++++++-----

What happens to exsting users whose flash is laid out the existing way,
when they upgrade to these device trees?

We really should not be putting partition layout info in the device tree
to begin with...

-Scott
