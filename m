Return-Path: <j-nomura@ce.jp.nec.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8ABE11A0004
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jul 2014 22:13:48 +1000 (EST)
Received: from tyo201.gate.nec.co.jp (TYO201.gate.nec.co.jp [210.143.35.51])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 26839140111
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2014 22:13:47 +1000 (EST)
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
To: "aik@ozlabs.ru" <aik@ozlabs.ru>
Subject: Re: [dm-devel] Regression in 3.15 on POWER8 with multipath SCSI
Date: Wed, 9 Jul 2014 12:13:12 +0000
Message-ID: <11AF7C027C4C02408624617A498607840132A448@BPXM12GP.gisp.nec.co.jp>
References: <20140630103058.GA17747@iris.ozlabs.ibm.com>
 <20140701193907.GA15306@redhat.com>
 <11AF7C027C4C02408624617A4986078401323542@BPXM12GP.gisp.nec.co.jp>
 <53BCBD2E.6010203@ozlabs.ru>
In-Reply-To: <53BCBD2E.6010203@ozlabs.ru>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Cc: Vladimir Davydov <vdavydov@parallels.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>, Mike Snitzer <snitzer@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 device-mapper development <dm-devel@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/14 12:55, Alexey Kardashevskiy wrote:
> On 07/08/2014 08:28 PM, Junichi Nomura wrote:
>> It seems Bart's issue has gone with the attached patch:
>> http://www.redhat.com/archives/dm-devel/2014-July/msg00035.html
>> Could you try if it makes any difference on your issue?
..
> This patch fixes IPR SCSI for my POWER8 box, e8099177 was the problem.

Thank you for the testing.

Mike Snitzer has picked up this patch for his tree:
https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/com=
mit/?h=3Dfor-next&id=3D75c76c45b76e53b7c2f025d30e7e308bfe331004

--=20
Jun'ichi Nomura, NEC Corporation
