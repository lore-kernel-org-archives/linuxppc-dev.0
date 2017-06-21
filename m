Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt6fP5RzSzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 00:34:05 +1000 (AEST)
Date: Wed, 21 Jun 2017 11:33:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Mark Wielaard <mark@klomp.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
Message-ID: <20170621143359.GP13640@kernel.org>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <1632232.7qGxppV1HK@agathebauer>
 <20170621124829.GM13640@kernel.org>
 <3364571.STeM6x1sE0@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3364571.STeM6x1sE0@agathebauer>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Jun 21, 2017 at 04:19:11PM +0200, Milian Wolff escreveu:
> On Mittwoch, 21. Juni 2017 14:48:29 CEST Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 21, 2017 at 10:16:56AM +0200, Milian Wolff escreveu:
> > > On Mittwoch, 21. Juni 2017 03:07:39 CEST Arnaldo Carvalho de Melo wrote:
> > > > Hi Millian, can I take this as an Acked-by or Tested-by?
> > > 
> > > I have no access to any PowerPC hardware. In principle the code looks
> > > fine, but that's all I can say here.
> > 
> > Ok, that would count as an Acked-by, i.e. from
> > Documentation/process/submitting-patches.rst:
> > 
> > -------------------------
> > 
> > Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
> > has at least reviewed the patch and has indicated acceptance.  Hence patch
> > mergers will sometimes manually convert an acker's "yep, looks good to me"
> > into an Acked-by: (but note that it is usually better to ask for an
> > explicit ack).
> > 
> > -------------------------
> > 
> > If you had a ppc machine _and_ had applied and tested the patch, that
> > would allow us to use a Tested-by tag.
> 
> I see, I'm still unfamiliar with this process. But yes, do consider it an 
> `Acked-by` from my side then.

Right, then there is another tag there that is relevant to this
discussion:

Link: http://lkml.kernel.org/r/1496312681-20133-1-git-send-email-pbonzini@redhat.com

which will has the Message-ID of the message with this patch, embedded
in a URL that when clicked will bring you to the thread where the patch
was submitted and the acks, tested-by, reviewed-by, etc were provided,
so that we can go back and check the history of the patch.

- Arnaldo
