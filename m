Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9474ADDF51
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 09:06:02 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5] qe: add ability to upload QE firmware
Date: Wed, 12 Dec 2007 23:05:41 +0100
References: <11970422334145-git-send-email-timur@freescale.com>
In-Reply-To: <11970422334145-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712122305.42860.arnd@arndb.de>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 December 2007, Timur Tabi wrote:
> Define the layout of a binary blob that contains a QE firmware and instru=
ctions
> on how to upload it. =A0Add function qe_upload_firmware() to parse the bl=
ob
> and perform the actual upload. =A0Fully define 'struct rsp' in immap_qe.h=
 to
> include the actual RISC Special Registers. =A0Added description of a new
> QE firmware node to booting-without-of.txt.

All the comments I had were addressed, mostly by convincing me that the
code was correct to start with, so

> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
