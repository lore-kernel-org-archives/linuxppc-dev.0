Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id A030DDE111
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:58:15 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
Date: Thu, 6 Dec 2007 16:58:08 +0100
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712061631.19485.arnd@arndb.de> <4758193B.5080707@freescale.com>
In-Reply-To: <4758193B.5080707@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712061658.08791.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 December 2007, Timur Tabi wrote:
> In reality, having the boot loader load the firmware will usually be the=
=20
> preferred approach, because that's simpler. =A0Having it in both U-Boot a=
nd the=20
> kernel covers all situations, though. =A0There would be no need for the b=
ootloader=20
> to pass the firmware to the kernel.

Ok, looks you were right from the start (again), thanks for your patience
explaining this to me.

	Arnd <><
