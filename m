Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLTW30DPdzDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 08:07:26 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NL7C1v067922
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 17:07:23 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dspxqtmjr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 17:07:14 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 23 Oct 2017 15:06:46 -0600
Date: Mon, 23 Oct 2017 14:06:38 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Balbir Singh <bsingharora@gmail.com>, ebiederm@xmission.com,
 mhocko@kernel.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH 02/25] powerpc: define an additional vma bit for
 protection keys.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
 <20170914143807.03cd9aa3@firefly.ozlabs.ibm.com>
 <1505376692.12628.191.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505376692.12628.191.camel@kernel.crashing.org>
Message-Id: <20171023210638.GB5488@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 06:11:32PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2017-09-14 at 14:38 +1000, Balbir Singh wrote:
> > On Fri,  8 Sep 2017 15:44:50 -0700
> > Ram Pai <linuxram@us.ibm.com> wrote:
> > 
> > > powerpc needs an additional vma bit to support 32 keys.
> > > Till the additional vma bit lands in include/linux/mm.h
> > > we have to define  it  in powerpc specific header file.
> > > This is  needed to get pkeys working on power.
> > > 
> > > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > > ---
> > 
> > "This" being an arch specific hack for the additional bit?
> 
> Arch VMA bits ? really ? I'd rather we limit ourselves to 16 keys first
> then push for adding the extra bit to the generic code.

(hmm.. this mail did not land in my mailbox :( Sorry for the delay. Just
saw it in the mailing list.)

I think this is good idea. I can code it such a way that we
support 16 or 32 keys depending on the availability of the vma bit.

No more hunks in the code.


RP
