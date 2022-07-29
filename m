Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5705DC00144
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 13:14:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LvSfF0Cmhz3fWY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 23:14:29 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LvSZ32g1gz2xml
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2022 23:10:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSZ12Mrfz4xG8;
	Fri, 29 Jul 2022 23:10:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: deller@gmx.de, mrochs@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, ukrishn@linux.ibm.com, manoj@linux.ibm.com, tzimmermann@suse.de, Nicholas Piggin <npiggin@gmail.com>, martin.petersen@oracle.com, jejb@linux.ibm.com
In-Reply-To: <f75b383673663e27f6b57e50b4abfb9fe3780b00.1657264228.git.christophe.leroy@csgroup.eu>
References: <f75b383673663e27f6b57e50b4abfb9fe3780b00.1657264228.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/4] video: fbdev: offb: Include missing linux/platform_device.h
Message-Id: <165909976850.253830.18083403914079325529.b4-ty@ellerman.id.au>
Date: Fri, 29 Jul 2022 23:02:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 8 Jul 2022 09:11:05 +0200, Christophe Leroy wrote:
> A lot of drivers were getting platform and of headers
> indirectly via headers like asm/pci.h or asm/prom.h
> 
> Most of them were fixed during 5.19 cycle but a newissue was
> introduced by commit 52b1b46c39ae ("of: Create platform devices
> for OF framebuffers")
> 
> [...]

Applied to powerpc/next.

[1/4] video: fbdev: offb: Include missing linux/platform_device.h
      https://git.kernel.org/powerpc/c/ebef8abc963b9e537c0a0d619dd8faf1b8f2b183
[2/4] scsi: cxlflash: Include missing linux/irqdomain.h
      https://git.kernel.org/powerpc/c/61657dcd528b75cd196adaf56890124c13953c8d
[3/4] powerpc: Remove asm/prom.h from asm/mpc52xx.h and asm/pci.h
      https://git.kernel.org/powerpc/c/4d5c5bad51935482437528f7fa4dffdcb3330d8b
[4/4] powerpc: Finally remove unnecessary headers from asm/prom.h
      https://git.kernel.org/powerpc/c/36afe68714d45edf34430d28e3dc787425ad8b22

cheers
