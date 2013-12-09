Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F40E2C00AB
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Dec 2013 10:26:24 +1100 (EST)
Message-ID: <1386631570.32037.40.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix "attempt to move .org backwards" error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 10 Dec 2013 10:26:10 +1100
In-Reply-To: <20131210101031.82b02468d32ddb89481b24b9@canb.auug.org.au>
References: <20131209191015.22974.31604.stgit@mars>
 <20131210101031.82b02468d32ddb89481b24b9@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linux-next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-12-10 at 10:10 +1100, Stephen Rothwell wrote:
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Works for me.  Thanks.  I will add this to linux-next today if Ben
> doesn't add it to his tree.

I will but probably not soon enough for your cut today

Cheers,
Ben.
