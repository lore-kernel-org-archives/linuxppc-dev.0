Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A43EF1A0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:38:04 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 29 Apr 2015 11:08:02 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 39104E0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 11:10:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3T5bx3i54526062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 11:07:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3T5bw25008973
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 11:07:59 +0530
Date: Wed, 29 Apr 2015 11:07:58 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 0/7] Fixes for perf probe issues on ppc
Message-ID: <20150429053758.GA17469@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150428135453.GL16849@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150428135453.GL16849@kernel.org>
Cc: linux-kernel@vger.kernel.org, masami.hiramatsu.pt@hitachi.com,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arnaldo Carvalho de Melo <acme@kernel.org> [2015-04-28 10:54:53]:

> Em Tue, Apr 28, 2015 at 05:35:33PM +0530, Naveen N. Rao escreveu:
> > This patchset fixes various issues with perf probe on powerpc across ABIv1 and
> > ABIv2:
> > - in the presence of DWARF debug-info,
> > - in the absence of DWARF, but with the symbol table, and
> > - in the absence of debug-info, but with kallsyms.
> > 
> > Arnaldo,
> > I have moved all patches to use __weak functions. Kindly take a look and let me
> > know if this is what you had in mind.
> 
> Ok, I applied all but the first, for which I am waiting for Masami's
> reaction, I kept Srikar's reviewed-by for the other patches, but would
> as well like to get his word that he keeps it after the __weak changes.
> 
> So, for now, I'll leave it for a while sitting in my local tree, to give
> time to Masami and Srikar, ok?
> 

Yes Arnaldo, I have looked at the patches after the __weak changes and
they look good to me.

> - Arnaldo
> 

-- 
Thanks and Regards
Srikar Dronamraju
