Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqJdn543YzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 07:52:29 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qqJdn17vTz9t8l
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2016 07:52:28 +1000 (AEST)
Date: Tue, 19 Apr 2016 23:52:23 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
cc: Michael Ellerman <mpe@ellerman.id.au>, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@ozlabs.org, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, live-patching@vger.kernel.org
Subject: Re: [PATCH 0/5] Live patching for powerpc
In-Reply-To: <5716A62F.6040900@gmail.com>
Message-ID: <alpine.LNX.2.00.1604192351560.27368@cbobk.fhfr.pm>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au>
 <alpine.LNX.2.00.1604151136320.27368@cbobk.fhfr.pm>
 <5716A62F.6040900@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Apr 2016, Balbir Singh wrote:

> Thanks, do we have a summary of what the relocation changes look like?

This work is queued in 
livepatching.git#for-4.7/arch-independent-klp-relocations

-- 
Jiri Kosina
SUSE Labs
