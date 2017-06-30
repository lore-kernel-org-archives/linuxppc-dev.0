Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzSJl3y8yzDr60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 17:07:19 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id f127so14430941pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 00:07:19 -0700 (PDT)
Date: Fri, 30 Jun 2017 17:07:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Anton
 Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 0/7] powerpc: build out kprobes blacklist -- series 3
Message-ID: <20170630170705.5d69edc6@roar.ozlabs.ibm.com>
In-Reply-To: <cover.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017 23:19:13 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This is the third in the series of patches to build out an appropriate
> kprobes blacklist for powerpc. Since posting the second series (*),
> there have been related changes to the code and I have brought that
> series forward to account for those changes. As such, all patches from
> the second series are included in this patchset.
> 
> This patchset now ensures that the newly added multiple kprobes test in
> the ftrace testsuite passes on powerpc64. Tested on both Elfv1 and
> Elfv2.
> 
> Changes since v4:
>   - Patch 5 changed to move system_call_exit() symbol before the mtmsrd,
>     along with an explanation for its placement.
>   - Patch 7 reverted to previous version moving the new symbol before
>     the mtmsrd as well.
>   - All other patches remain unchanged from v4.

These all look good to me now.

Thanks,
Nick
