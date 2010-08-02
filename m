Return-Path: <kumar.gala@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143]) by ozlabs.org (Postfix) with ESMTP id C7E9DB70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 05:52:57 +1000 (EST)
Received: from mail2-db3 (localhost.localdomain [127.0.0.1])	by
	mail2-db3-R.bigfish.com (Postfix) with ESMTP id C9284470810	for
	<linuxppc-dev@lists.ozlabs.org>; Mon,  2 Aug 2010 19:37:36 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.242])	by
	mail2-db3.bigfish.com (Postfix) with ESMTP id 9A5261718050	for
	<linuxppc-dev@lists.ozlabs.org>; Mon,  2 Aug 2010 19:37:36 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o72JbNZQ027673	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 2 Aug 2010 12:37:33 -0700 (MST)
Subject: Re: [PATCH v2 1/2] powerpc/85xx: kexec for SMP 85xx BookE systems
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1279746894-29529-2-git-send-email-msm@freescale.com>
Date: Mon, 2 Aug 2010 14:37:22 -0500
Message-ID: <F79AF69B-D763-4A4F-9294-4758DB1AC0A7@freescale.com>
References: <1279746894-29529-1-git-send-email-msm@freescale.com>
	<1279746894-29529-2-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2010, at 4:14 PM, Matthew McClintock wrote:

> Adds support for kexec on 85xx machines for the BookE platform.
> Including support for SMP machines
>=20
> Based off work from Maxim Uvarov <muvarov@mvista.com>
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/Kconfig              |   10 +++---
> arch/powerpc/platforms/85xx/smp.c |   63 =
+++++++++++++++++++++++++++++++++++++
> 2 files changed, 68 insertions(+), 5 deletions(-)

applied to next

- k=
