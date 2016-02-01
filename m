Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D088F1A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 21:40:07 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 1 Feb 2016 20:40:07 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A65622BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 21:39:58 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u11AdQgm49610842
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 21:39:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u11AdQ8Q010069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 21:39:26 +1100
Subject: Re: [PATCH] Fix kgdb on little endian ppc64le
To: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <20160201170325.4ec4324e@cotter.ozlabs.ibm.com>
Cc: kgdb-bugreport@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56AF35C4.2050700@au1.ibm.com>
Date: Mon, 1 Feb 2016 21:39:00 +1100
MIME-Version: 1.0
In-Reply-To: <20160201170325.4ec4324e@cotter.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/02/16 17:03, Balbir Singh wrote:
> From: Balbir Singh <bsingharora@gmail.com>
>
> I spent some time trying to use kgdb and debugged my inability to
> resume from kgdb_handle_breakpoint(). NIP is not incremented
> and that leads to a loop in the debugger.
>
> I've tested this lightly on a virtual instance with KDB enabled.
> After the patch, I am able to get the "go" command to work as
> expected
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Should this be Cc'd to stable?


-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
