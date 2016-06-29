Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfwcw44DmzDqnn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:22:55 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, Pat Wall <pjwall@mac.com>,
 matthew@a-eon.com, aperez@alexperez.com, R.T.Dickinson <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Wed, 29 Jun 2016 20:56:13 +0100 (BST)
Message-ID: <4867f6e02a8.141b01ac@auth.smtp.1and1.co.uk>
In-Reply-To: <87vb0t4cs0.fsf@skywalker.in.ibm.com>
References: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
 <87vb0t4cs0.fsf@skywalker.in.ibm.com>
Subject: Re: Proposed: Patch to fix boot on PA6T
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Aneesh

On 28/06/2016, Aneesh Kumar K.V wrote:
> Another option is to init it along with rest of the variables as done in
> hash__early_init_mmu(void)/radix__early_init_mmu(void)

*FACEPALM* Why didn't I think of that! I've made this change and seems to work
- obviously I can't test on a Radix system though, as I don't have access to
one.

Patch comming shortly

Regards
Darren
