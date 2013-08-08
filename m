Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 375BD2C00AC
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 14:16:58 +1000 (EST)
Message-ID: <1375935373.12551.11.camel@pasglop>
Subject: Re: [RFC PATCH 1/9] powerpc: Split the common exception prolog
 logic into two section.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 14:16:13 +1000
In-Reply-To: <52031A18.90804@linux.vnet.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093806.5389.41596.stgit@mars.in.ibm.com>
 <52031A18.90804@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-08 at 09:40 +0530, Anshuman Khandual wrote:
> On 08/07/2013 03:08 PM, Mahesh J Salgaonkar wrote:
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > This patch splits the common exception prolog logic into two parts to
> > facilitate reuse of existing code in the next patch. The second part will
> > be reused in the machine check exception routine in the next patch.
> > 
> 
> Please avoid describing the functionality as a requirement for upcoming
> sibling patches. Justification to split the code should be generic functional
> or code organizational requirement. We should avoid the word "next patch" in
> the commit message, as it would be confusing when you read it later point of
> time. The commit message should be self sufficient pertaining to the exact
> code change set in consideration.

Ugh ?

It's absolutely common practice to have a patch doing such a split
*specifically* for the purpose of subsequent patches....

In fact it's even *recommended* to separate the split from the
subsequent code change as the code split patch should be a nop, and it
makes the subsequent patch a lot easier to review.

Ben.
