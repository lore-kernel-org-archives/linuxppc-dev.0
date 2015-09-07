Return-Path: <bharata@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7EF81A2AED
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 20:24:34 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Mon, 7 Sep 2015 15:54:32 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8D881125801D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 15:53:49 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t87AOR0022610092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 15:54:27 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t87AOQfu012766
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 15:54:27 +0530
Date: Mon, 7 Sep 2015 15:54:25 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bharata B Rao <bharata.rao@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [FIX] powerpc/pseries: Release DRC when configure_connector fails
Message-ID: <20150907102425.GA678@in.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1441361052-3319-1-git-send-email-bharata.rao@gmail.com>
 <20150907092204.AF166140281@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150907092204.AF166140281@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 07, 2015 at 07:22:04PM +1000, Michael Ellerman wrote:
> On Fri, 2015-04-09 at 10:04:12 UTC, Bharata B Rao wrote:
> > From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > 
> > dlpar_cpu_probe() should release the acquired DRC if configure_connector
> > call fails.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> > Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> 
> Which commit caused this to be a bug? Or has it always been there?
> 
> What is the symptom, is it catastrophic, or just cosmetic?
> 
> Should the fix go to stable?

Posted v1 with the above questions answered appropriately.

Regards,
Bharata.
