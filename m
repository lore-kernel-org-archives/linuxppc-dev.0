Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id BCC23DDEB7
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 22:57:01 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id A46EE14288
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:57:01 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27341-10 for <linuxppc-dev@ozlabs.org>;
	Wed, 17 Oct 2007 14:57:00 +0200 (CEST)
Message-ID: <47160689.4020301@semihalf.com>
Date: Wed, 17 Oct 2007 14:56:41 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] [POWERPC] MPC5200: update gpt binding, add restart support
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a reworked version of patches to MPC5200 common code that were send
together with the TQM5200/CM5200/Motion-PRO board support chnages.

As there are some open issues in a board support code and to avoid
additional respin I would like to have those reviewed first.

[PATCH 1/4] [POWERPC] Add mpc52xx_find_and_map_path(), refactor utility functions
[PATCH 2/4] [POWERPC] Update device tree binding for mpc5200 gpt
[PATCH 3/4] [POWERPC] Add restart support for mpc52xx based platforms
[PATCH 4/4] [POWERPC] Enable restart support for lite5200 board

Cheers,
Marian Balakowicz
