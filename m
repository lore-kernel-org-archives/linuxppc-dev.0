Return-Path: <kmcmarti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 600F72C0092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 02:26:37 +1000 (EST)
Date: Sun, 26 May 2013 12:26:32 -0400
From: Kyle McMartin <kmcmarti@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc: remove unused devm_ioremap_prot
Message-ID: <20130526162632.GB19205@redacted.bos.redhat.com>
References: <20130525165425.GC30204@redacted.bos.redhat.com>
 <1369521875.3557.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369521875.3557.7.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 26, 2013 at 08:44:35AM +1000, Benjamin Herrenschmidt wrote:
> It's not used ... yet. It's needed if we ever are to implement
> something like devm_ioremap_wc(). I suspect if things like framebuffer
> or even IB drivers start using devm this will be needed.
> 
> Any specific reason why you want to take it out ?
>

No particular reason...

ioremap on ppc64 came up in conversation with Adam Jackson, and I
noticed ppc64 had an interface nobody else had, figured it might have
been added, then forgotten.

regards, Kyle
