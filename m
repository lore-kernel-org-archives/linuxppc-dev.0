Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRGqg1sznzDr25
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 03:23:26 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9VGFMlD082804
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 12:23:24 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dxv41j261-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 12:23:23 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 31 Oct 2017 16:23:22 -0000
Date: Tue, 31 Oct 2017 21:53:16 +0530
From: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
 <20171031153004.GA31864@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171031153004.GA31864@lst.de>
Message-Id: <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/31 03:30PM, Torsten Duwe wrote:
> On Tue, Oct 31, 2017 at 07:49:59PM +0530, Naveen N . Rao wrote:
> > Hi Kamalesh,
> > Sorry for the late review. Overall, the patch looks good to me.
> 
> If you're good with a hammer...
> 
> Maybe I failed to express my views properly; I find the whole approach
> mislead in the first place. I had asked questions previously because it
> would have never come to my mind that someone would deliberately, without
> a compelling reason, creates broken live patch modules and then tries
> to fix them up with some ugly band-aid in the kernel. So for the record:
> 
> NAK'd-by: Torsten Duwe <duwe@suse.de>

Hmm... that wasn't evident at all given Balbir's reponse to your 
previous concerns and your lack of response for the same:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg125350.html


- Naveen
