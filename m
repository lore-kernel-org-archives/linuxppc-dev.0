Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B358DDDE46
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 05:57:51 +1100 (EST)
Message-ID: <4741DCBA.4050405@ru.mvista.com>
Date: Mon, 19 Nov 2007 21:58:02 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/21] ide/Kconfig: fix mpc8xx host driver dependencies
References: <200711182315.19408.bzolnier@gmail.com>
In-Reply-To: <200711182315.19408.bzolnier@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bartlomiej Zolnierkiewicz wrote:

> Only LWMON, IVMS8, IVML24 and TQM8xxL platforms have the needed
> defines (IDE0_BASE_OFFSET and friends) in the platform header file.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
