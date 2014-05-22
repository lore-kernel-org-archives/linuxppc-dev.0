Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A426F1A059E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 15:30:06 +1000 (EST)
Message-ID: <1400736606.14864.11.camel@concordia>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for
 transactional memory register sets
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pedro Alves <palves@redhat.com>
Date: Thu, 22 May 2014 15:30:06 +1000
In-Reply-To: <5372547D.8040209@redhat.com>
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <5372547D.8040209@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, avagin@openvz.org, Roland McGrath <roland@hack.frob.com>,
 oleg@redhat.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-13 at 18:21 +0100, Pedro Alves wrote:
> I wonder whether people are getting Roland's address from?
> 
> It's frequent that ptrace related patches end up CCed to
> roland@redhat.com, but, he's not been at Red Hat for a few years
> now.  Roland, do you still want to be CCed on ptrace-related
> issues?  If so, there's probably a script somewhere in the
> kernel that needs updating.  If not, well, it'd be good
> if it were updated anyway.  :-)

In MAINTAINERS I see:

PTRACE SUPPORT
M:	Roland McGrath <roland@redhat.com>
M:	Oleg Nesterov <oleg@redhat.com>
S:	Maintained


cheers
