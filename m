Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xskR71B6pzDrJm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 00:23:14 +1000 (AEST)
Subject: [PATCH] powerpc: Fix handling of alignment interrupt on dcbz
 instruction
To: Michal Sojka <sojkam1@fel.cvut.cz>,
 Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
References: <20170913045124.GA5071@fergus.ozlabs.ibm.com>
 <56511543-E4A4-45B9-8BE3-A8FA2D8BCE0E@ellerman.id.au>
 <87ingnyspl.fsf@steelpick.2x.cz>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <2a58c736-9daa-6cfa-a5b3-284a019e33dc@xenosoft.de>
Date: Wed, 13 Sep 2017 16:23:02 +0200
MIME-Version: 1.0
In-Reply-To: <87ingnyspl.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13 September 2017 at 09:15AM, Michal Sojka wrote:
> On Wed, Sep 13 2017, Michael Ellerman wrote:
>> Michal, Christian, can you please confirm this fixes the problems you
>> were seeing.
> Yes, it fixes my problem. Thanks.
>
> -Michal
>
It also fixes my problem. Many thanks!

-- Christian
