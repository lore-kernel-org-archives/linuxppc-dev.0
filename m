Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 83A771A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 02:16:33 +1000 (AEST)
Message-ID: <552A9A5D.4070208@c-s.fr>
Date: Sun, 12 Apr 2015 18:16:29 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 01/11] powerpc/8xx: remove remaining unnecessary code in
 FixupDAR
References: <20150203113816.E77811A5F13@localhost.localdomain>
 <20150326213215.GA21815@home.buserror.net>
In-Reply-To: <20150326213215.GA21815@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/03/2015 22:32, Scott Wood a écrit :
> On Tue, Feb 03, 2015 at 12:38:16PM +0100, LEROY Christophe wrote:
>> Since commit 33fb845a6f01 ("powerpc/8xx: Don't use MD_TWC for walk"), MD_EPN and
>> MD_TWC are not writen anymore in FixupDAR so saving r3 has become useless.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> v2: no change
>> v3: no change
> This doesn't apply cleanly.
>
>
You already applied part of that patchset it in your next tree, 
including that one (commit 2374d0a).
You told me to re-submit a patchset with only the remaining ones, 
therefore I sent v4 on the 4th of Feb, based on your tree.

Christophe
