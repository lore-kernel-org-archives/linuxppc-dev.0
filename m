Return-Path: <micha.nelissen@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by ozlabs.org (Postfix) with ESMTP id 643B82C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2012 03:43:23 +1100 (EST)
From: Micha Nelissen <micha.nelissen@Prodrive.nl>
To: 'Scott Wood' <scottwood@freescale.com>
Subject: RE: powerpc: Don't silently handle machine checks from userspace
Date: Tue, 6 Nov 2012 16:43:19 +0000
Message-ID: <39F93B8F6D09AC4DA45E2F19603FA69C324F2605@exc02.bk.prodrive.nl>
References: <5093B318.9040305@prodrive.nl> <1351874164.5089.1@snotra>
 <39F93B8F6D09AC4DA45E2F19603FA69C324EEDCD@exc02.bk.prodrive.nl>
 <1352219655.21833.0@snotra>
In-Reply-To: <1352219655.21833.0@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Martijn de Gouw <martijn.de.gouw@prodrive.nl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood [mailto:scottwood@freescale.com]
>> Hmm I guess there is no simple solution then, since the "recover"
>> function also prints the kernel messages about the machine check
>> being in kernel mode without having checked whether it really was in
>> kernel mode. In the past the user mode check was in between.
>=20
> It shouldn't be that difficult to make it say "in user mode" or "in
> kernel mode" depending on which it was... or just remove that phrase
> altogether and let the following output indicate whether it was in
> kernel mode.

Well printing the correct message is only part of it: do "we" want to pass =
guarded load errors (RapidIO bus errors) to user space or not? And if we pa=
ss them, should we print a kernel message at all?

Micha
