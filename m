Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mailx.hitachi.co.jp (mailx.hitachi.co.jp [133.145.228.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 2D3271A0BEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 08:32:44 +1000 (AEST)
Received: from mail9.hitachi.co.jp (mail9.hitachi.co.jp [133.145.228.44])
 by mailx.hitachi.co.jp (Postfix) with ESMTP id BC24C1770033
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 07:17:08 +0900 (JST)
Message-ID: <554006DD.50202@hitachi.com>
Date: Wed, 29 Apr 2015 07:17:01 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: Re: [PATCH v3 0/7] Fixes for perf probe issues on ppc
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150428135453.GL16849@kernel.org>
In-Reply-To: <20150428135453.GL16849@kernel.org>
Content-Type: text/plain; charset=windows-1252
Cc: linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, srikar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/04/28 22:54, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 28, 2015 at 05:35:33PM +0530, Naveen N. Rao escreveu:
>> This patchset fixes various issues with perf probe on powerpc across ABIv1 and
>> ABIv2:
>> - in the presence of DWARF debug-info,
>> - in the absence of DWARF, but with the symbol table, and
>> - in the absence of debug-info, but with kallsyms.
>>
>> Arnaldo,
>> I have moved all patches to use __weak functions. Kindly take a look and let me
>> know if this is what you had in mind.
> 
> Ok, I applied all but the first, for which I am waiting for Masami's
> reaction, I kept Srikar's reviewed-by for the other patches, but would
> as well like to get his word that he keeps it after the __weak changes.
> 
> So, for now, I'll leave it for a while sitting in my local tree, to give
> time to Masami and Srikar, ok?

OK, I reviewed all the patches in this series :)

Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
for this series.

Thank you!

-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
