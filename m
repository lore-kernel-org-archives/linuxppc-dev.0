Return-Path: <sojkam1@fel.cvut.cz>
Received: from smtpx.feld.cvut.cz (smtpx.feld.cvut.cz [147.32.192.33])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xsXy600Z0zDqmg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:15:56 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH] powerpc: Fix handling of alignment interrupt on dcbz
 instruction
In-Reply-To: <56511543-E4A4-45B9-8BE3-A8FA2D8BCE0E@ellerman.id.au>
References: <20170913045124.GA5071@fergus.ozlabs.ibm.com>
 <56511543-E4A4-45B9-8BE3-A8FA2D8BCE0E@ellerman.id.au>
Date: Wed, 13 Sep 2017 09:15:50 +0200
Message-ID: <87ingnyspl.fsf@steelpick.2x.cz>
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

On Wed, Sep 13 2017, Michael Ellerman wrote:
> Michal, Christian, can you please confirm this fixes the problems you
> were seeing.

Yes, it fixes my problem. Thanks.

-Michal
