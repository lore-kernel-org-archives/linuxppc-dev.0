Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGB7C0j2pzF0Sh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 23:20:37 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w09CKVsL122752
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jan 2018 07:20:34 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fctthg902-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jan 2018 07:20:33 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Tue, 9 Jan 2018 05:20:13 -0700
Date: Tue, 9 Jan 2018 10:20:04 -0200
From: joserz@linux.vnet.ibm.com
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S: Add capabilities for Meltdown/Spectre
 workarounds
References: <20180109044815.GA19326@fergus.ozlabs.ibm.com>
 <1515487154.1993.3.camel@gmail.com>
 <20180109125726.39687794@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180109125726.39687794@kitsune.suse.cz>
Message-Id: <20180109122004.gaskxr67feftftsw@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 09, 2018 at 12:57:26PM +0100, Michal Suchánek wrote:
> On Tue, 09 Jan 2018 19:39:14 +1100
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:
> 
> > 
> > s/behavior/behaviour
> 
> Nope. Either is valid and the shorter American spelling is actually
> more common.
> 
> If you must nickpick choose something actually broken :p

Suraj is right:

struct h_cpu_char_result {
       u64 character;
       u64 behaviour;
};

> 
> Thanks
> 
> Michal
> 
