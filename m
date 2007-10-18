Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id A1259DDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:44:29 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id F120C14383
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:44:28 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11661-01 for <linuxppc-dev@ozlabs.org>;
	Thu, 18 Oct 2007 20:44:27 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 838D3142D3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:44:27 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v2 0/4] [POWERPC] MPC5200: update gpt binding,
	add restart support
To: linuxppc-dev@ozlabs.org
Date: Thu, 18 Oct 2007 20:44:07 +0200
Message-ID: <20071018184407.3584.3513.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's the second version of MPC5200 patches, please review. Thanks!

[POWERPC] Enable restart support for lite5200 board
[POWERPC] Add restart support for mpc52xx based platforms
[POWERPC] Update device tree binding for mpc5200 gpt
[POWERPC] Add mpc52xx_find_and_map_path(), refactor utility functions

Cheers,
m.
