Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41nClz1rMZzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 04:08:14 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7AHxvm8049331
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 14:08:11 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kseu5hu2y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 14:08:11 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 10 Aug 2018 14:08:10 -0400
Date: Fri, 10 Aug 2018 15:08:00 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Simon Guo <wei.guo.simon@gmail.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@d-silva.org>, Joe Perches <joe@perches.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
 "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 5/6] powerpc: Add show_user_instructions()
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
 <20180801213320.11203-6-muriloo@linux.ibm.com>
 <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
 <20180803004201.GA5891@kermit-br-ibm-com>
 <69cf990b-d4aa-97e7-be3b-7936caa91688@c-s.fr>
 <87pnyzhm9l.fsf@concordia.ellerman.id.au>
 <20180803113141.GA5476@kermit-br-ibm-com>
 <1cfa56a3-027d-cf2c-3150-12aa45a35bd9@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1cfa56a3-027d-cf2c-3150-12aa45a35bd9@c-s.fr>
Message-Id: <20180810180800.GB30475@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Fri, Aug 10, 2018 at 11:29:43AM +0200, Christophe LEROY wrote:
>
>
> Le 03/08/2018 à 13:31, Murilo Opsfelder Araujo a écrit :
> > Hi, everyone.
> >
> > I'd like to thank you all that contributed to refining and making this
> > series better.  I did appreciate.
> >
> > Thank you!
>
> You are welcome.
>
> It seems that nested segfaults don't print very well. The code line is split
> in two, le second half being alone on one line. Any way to avoid that ?

What do you mean by "nested segfaults"?  I'd guess it's related to nested
virtualization, e.g.: host (kvm hv) -> guest1 (kvm pr) -> guest2?  So the
segfault would have been originated in guest2?

Can you provide us with more details about how to reproduce that?

Anyway, is "XXXXXXXX" so important that it needs to be printed at all?  Can't we
just discard it and not print it?

Murilo
