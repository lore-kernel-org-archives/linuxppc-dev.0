Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slTZB2tf0zDskL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 08:21:38 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8TMHiUu008061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 18:21:36 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25s8st6d8e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 18:21:35 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 19:21:33 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A5D461DC006F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 18:21:31 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8TMLVpC4927662
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 19:21:31 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8TMLU6X013780
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 19:21:31 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
Date: Thu, 29 Sep 2016 19:21:29 -0300
In-Reply-To: <87eg42xtzn.fsf@x220.int.ebiederm.org>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1743059.2ZOQaNILxh@hactar> <87eg42xtzn.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2846678.ltpVeSnPm7@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 29 September 2016, 16:43:08 schrieb Eric W. Biederman:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > Hello Eric,
> > 
> > Am Dienstag, 20 September 2016, 11:07:29 schrieb Eric W. Biederman:
> >> A semi-generic concept called a hand-over buffer seems to be a
> >> construction of infrustructure for no actual reason that will just
> >> result in confusion.  There are lots of things that are handed over,
> >> the
> >> flattend device tree, ramdisks, bootparams on x86, etc, etc.  ima is
> >> not
> >> special in this execpt for being perhaps the first addition that we are
> >> going to want the option of including on most architectures.
> > 
> > Ok, I understand. I decided to implement a generic concept because I
> > thought that proposing a feature that is more useful than what I need
> > it for would increase its chance of being accepted. It's interesting to
> > see that it had the opposite effect.
> 
> Yes.  In this case it was not clear that anyone else could use it, and
> being less generic you can tweak the needs of the code to ima without
> anyone having to worry about it.
> 
> So thank you very much for making the code more specific to the
> circumstances.

Thank you very much for your feedback and your reviews!

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
