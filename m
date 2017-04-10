Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w24nf5FPszDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:37:42 +1000 (AEST)
Date: Tue, 11 Apr 2017 08:37:21 +1000
From: Anton Blanchard <anton@samba.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, chris@distroguy.com, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 viro@zeniv.linux.org.uk
Subject: Re: [PATCH] ppc64/kprobe: Fix oops when kprobed on 'stdu' instruction
Message-ID: <20170411083721.0c9f9177@kryten>
In-Reply-To: <1491837657-4918-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1491837657-4918-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

Hi Ravi,

> If we set a kprobe on a 'stdu' instruction on powerpc64, we see a
> kernel OOPS:

Ouch! We should mark this for stable.

Anton
