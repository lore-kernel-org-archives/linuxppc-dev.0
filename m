Return-Path: <amwang@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 38B27B6F85
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 20:57:48 +1100 (EST)
Message-ID: <4EBB9FEE.9090905@redhat.com>
Date: Thu, 10 Nov 2011 17:57:02 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v4 02/10] fadump: Reserve the memory for firmware
 assisted	dump.
References: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
 <20111107095527.1997.79902.stgit@mars.in.ibm.com>
In-Reply-To: <20111107095527.1997.79902.stgit@mars.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 Milton Miller <miltonm@bga.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Mahesh,

Your patch seems have some style problems... checkpatch.pl complains,

total: 330 errors, 1 warnings, 355 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
       scripts/cleanfile

Could use scripts/checkpatch.pl to check your patch?

Thanks.
