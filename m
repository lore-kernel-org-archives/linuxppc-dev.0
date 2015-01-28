Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64C071A09EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 16:43:15 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 28 Jan 2015 11:13:12 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D87B1E0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 11:14:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0S5h5hX33423518
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 11:13:06 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0S5h5xR030937
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 11:13:05 +0530
Date: Wed, 28 Jan 2015 11:12:45 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCHv2 0/8] Fix perf probe issues on powerpc
Message-ID: <20150128054245.GA2078@naverao1-tp.in.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/12/15 08:20PM, Naveen N Rao wrote:
> This patchset fixes various issues with perf probe on powerpc across ABIv1 and
> ABIv2:
> - in the presence of DWARF debug-info,
> - in the absence of DWARF, but with the symbol table, and
> - in the absence of debug-info, but with kallsyms.
> 
> Applies cleanly on -tip. Tested on ppc64 BE and LE.
> 
> Changes from previous version:
> Addressed various review comments from Mike Ellerman largely to generalize
> changes. Some of the simpler patches have been retained in their previous form
> to limit code churn, while others have been generalized by introducing arch
> helpers. Individual patches have more details.

Michael,
Can you please take a quick look at this?

- Naveen
 
