Return-Path: <Alexander.Levin@microsoft.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0096.outbound.protection.outlook.com [104.47.38.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw9sf0RDTzF0VS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 07:06:45 +1100 (AEDT)
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.9 005/219] kretprobes: Ensure probe location
 is at function entry
Date: Mon, 5 Mar 2018 20:06:39 +0000
Message-ID: <20180305200638.fp3lxnkslgnlysxs@sasha-lappy>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-5-alexander.levin@microsoft.com>
 <1520232322.k5aakv6abc.naveen@linux.ibm.com>
In-Reply-To: <1520232322.k5aakv6abc.naveen@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2018 at 12:32:57PM +0530, Naveen N. Rao wrote:
>Hi Sasha,
>
>Sasha Levin wrote:
>>From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
>>
>>[ Upstream commit 90ec5e89e393c76e19afc845d8f88a5dc8315919 ]
>>
>
>Sorry if this is obvious, but why was this patch picked up for=20
>-stable?  I don't see the upstream commit tagging -stable, so curious=20
>why this was done.
>
>I don't think this patch should be pushed to -stable since this is not=20
>really a bug fix. There are also other dependencies for this change=20
>(see commit a64e3f35a45f4a, for instance), including how userspace=20
>(perf) builds out the retprobe argument. As such, please drop this=20
>from -stable (for 3.18. 4.4 and 4.9).

Hi Naveen,

It's an automatic selection process that attempts to find commits that
should be in stable but weren't tagged as such.

I'll drop this patch, thanks!

--=20

Thanks,
Sasha=
