Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdBgL2wFwzDvk1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 18:49:34 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBD7n18Z096511
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 02:49:31 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27a26pwn5e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 02:49:31 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 13:19:25 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A87CBE0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 13:19:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBD7miak26542114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 13:18:44 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBD7nIF2029578
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 13:19:21 +0530
Date: Tue, 13 Dec 2016 13:19:16 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Ananth N <ananth@in.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: sstep.c: Add modsw, moduw instruction
 emulation
References: <20161207174515.7628-1-prasannatsmkumar@gmail.com>
 <20161213060302.GB4109@naverao1-tp.localdomain>
 <CANc+2y4rMh6WbN6VDSku=omVxfZ95S=V+cVdd+Kb_HMrk59z2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANc+2y4rMh6WbN6VDSku=omVxfZ95S=V+cVdd+Kb_HMrk59z2g@mail.gmail.com>
Message-Id: <20161213074916.GD4109@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/12/13 01:06PM, PrasannaKumar Muralidharan wrote:
> Hi Naveen,
> 
> >> Add modsw and moduw instruction emulation support to analyse_instr.
> >> modsw is an x-form instruction that calculates signed modulo of values
> >> stored in registers. moduw is similar to modsw but it works with
> >> unsigned values.
> >>
> >> Changes in v2:
> >> Don't update CR register as the instruction does not touch that
> >> Arrange extended opcode in numerical order
> >
> > This changelog should come after '---' below so that it doesn't get
> > included in the commit message.
> 
> Oh, I see. Should I send the patch again with the above change? If so
> should I mark it v3 or just v2?

Easier for benh/mpe if you do ;)
Be sure to include my reviewed-by tag in your v3.

- Naveen

> 
> > Apart from that, for this patch:
> > Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> Thanks and regards,
> PrasannaKumar
> 
