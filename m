Return-Path: <prvs=72862f5cb=Bart.VanAssche@wdc.com>
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Tlhq3YbWzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 00:11:55 +1000 (AEST)
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "sachinp@linux.vnet.ibm.com"
 <sachinp@linux.vnet.ibm.com>, "jack@suse.com" <jack@suse.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "MPT-FusionLinux.pdl@broadcom.com"
 <MPT-FusionLinux.pdl@broadcom.com>
Subject: Re: [4.18.0-rc4][bisected a063057d][mpt3sas] WARNING: CPU: 87 PID:
 18868 at block/blk-core.c:781 blk_cleanup_queue+0x20c/0x220
Date: Mon, 16 Jul 2018 14:00:27 +0000
Message-ID: <453e3f042dfbb4c848cb434db888f9051c58686a.camel@wdc.com>
References: <1531731189.15016.15.camel@abdul.in.ibm.com>
In-Reply-To: <1531731189.15016.15.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-16 at 14:23 +-0530, Abdul Haleem wrote:
+AD4- mpt3sas module unload triggered a warning at block/blk-core.c:781 on =
a
+AD4- powerpc bare-metal running mainline kernel
+AD4-=20
+AD4- WARN+AF8-ON+AF8-ONCE() was introduced with commit a063057 : block: Fi=
x a race
+AD4- between request queue removal and the block cgroup controller

Please check whether the following patch series fixes this regression: +AFs=
-PATCH
v3 0/2+AF0- Ensure that a request queue is dissociated from the cgroup cont=
roller
(https://www.mail-archive.com/linux-block+AEA-vger.kernel.org/msg21897.html=
).

Thanks,

Bart.
