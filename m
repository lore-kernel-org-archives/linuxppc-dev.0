Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 16364DDDA1
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2009 06:47:54 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so775053yxb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 11:47:52 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Sat, 14 Feb 2009 14:47:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: 4xx tree updates
Message-ID: <20090214194732.GA30783@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

I've been rather busy lately and have unfortunately gotten behind on
updating the 4xx tree.  I spent some time this weekend looking over
the patches queued up, and fortunately there were not too many.  I'm
doing some build testing of these 4 today:

commit 6c7120902305b3a21460cd2f0f917a39307df566
Author: Madhulika Madishetty <mmadishetty@amcc.com>

    AMCC PPC 460SX redwood SoC platform initial framework

commit 41b6a085e48d0d9e1200946755f49f31dd930137
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>

    powerpc/4xx: Enable PCI domains on 4xx

commit 018f76ec516c09a5381e517d0739d377a60ec0d5
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>

    powerpc/4xx: Add missing USB and i2c devices to Canyonlands

commit e12401222f749c37277a313d631dc024bbfd3b00
Author: Yuri Tikhonov <yur@emcraft.com>

    powerpc/44x: Support for 256KB PAGE_SIZE

Barring any unforseen issues with these, I'll push them to my
next branch tomorrow and ask Ben to pull them shortly thereafter.

If I've missed any patches that should be headed for 2.6.30, please
let me know!

josh
