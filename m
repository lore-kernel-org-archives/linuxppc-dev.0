Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYC813jmGzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 23:56:33 +1000 (AEST)
Received: from smtprelay.hostedemail.com (smtprelay0045.hostedemail.com
 [216.40.44.45])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rYC810Q8bz9sxb
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2016 23:56:32 +1000 (AEST)
Date: Mon, 20 Jun 2016 09:56:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, karol
 herbst <karolherbst@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Pekka Paalanen  <ppaalanen@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Ben Skeggs  <bskeggs@redhat.com>, Yinghai Lu
 <yinghai@kernel.org>, koriakin@0x04.net
Subject: Re: [PATCH] tracing: Expose CPU physical addresses (resource
 values) for PCI devices
Message-ID: <20160620095621.6f188668@gandalf.local.home>
In-Reply-To: <1466202203.24271.76.camel@au1.ibm.com>
References: <20160511190657.5898.4248.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160617175901.7bd90d14@gandalf.local.home>
 <1466202203.24271.76.camel@au1.ibm.com>
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

On Sat, 18 Jun 2016 08:23:23 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Fri, 2016-06-17 at 17:59 -0400, Steven Rostedt wrote:
> > Sorry for the late reply, this patch got pushed down in my INBOX.
> > 
> > Could I get someone from PPC to review this patch, just to be safe?  
> 
> The patch makes sense, I can try getting somebody onto porting
> mmiotrace one of these days.
> 

OK, thanks!

I'll pull this into my for-next repo then.

-- Steve
