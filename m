Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvrTT46FjzDrS2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 18:03:08 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25714iT023961
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 02:03:06 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gguqjj248-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 02:03:05 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 5 Mar 2018 07:03:04 -0000
Date: Mon, 05 Mar 2018 12:32:57 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH AUTOSEL for 4.9 005/219] kretprobes: Ensure probe location
 is at function entry
To: Sasha Levin <Alexander.Levin@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-5-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-5-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1520232322.k5aakv6abc.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sasha,

Sasha Levin wrote:
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
>=20
> [ Upstream commit 90ec5e89e393c76e19afc845d8f88a5dc8315919 ]
>=20

Sorry if this is obvious, but why was this patch picked up for -stable? =20
I don't see the upstream commit tagging -stable, so curious why this was=20
done.

I don't think this patch should be pushed to -stable since this is not=20
really a bug fix. There are also other dependencies for this change (see=20
commit a64e3f35a45f4a, for instance), including how userspace (perf)=20
builds out the retprobe argument. As such, please drop this from -stable=20
(for 3.18. 4.4 and 4.9).

Thanks,
Naveen

=
