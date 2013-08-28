Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 77A822C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 08:11:07 +1000 (EST)
Message-ID: <1377727813.3819.156.camel@pasglop>
Subject: Re: [PATCH v4 09/31] powerpc/fsl-pci: improve clock API use
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Sittig <gsi@denx.de>
Date: Thu, 29 Aug 2013 08:10:13 +1000
In-Reply-To: <20130828155944.GA30987@book.gsilab.sittig.org>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-10-git-send-email-gsi@denx.de>
 <20130828120827.GB26379@book.gsilab.sittig.org>
 <20130828155944.GA30987@book.gsilab.sittig.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-28 at 17:59 +0200, Gerhard Sittig wrote:
> On Wed, Aug 28, 2013 at 14:08 +0200, Gerhard Sittig wrote:
> > 
> > [ re-created the Cc: list, this is about the PCI clock exclusively ]
> 
> I just noticed by coincidence that the message which I received
> back from the linuxppc-dev ML appeared to have dropped Benjamin
> Herrenschmidt and Kumar Gala from the Cc: list -- while they do
> appear in the header of the message that I have sent and I can't
> see what might have caused the loss of information. :-O

Don't bother with me. I haven't had the bandwidth to look at that
at all. I'll leave Anatolij the responsibility here :-)

Cheers,
Ben.

> Do you want me to re-send the message for the benefit of
> potential followups, or is it OK that you receive the message via
> the list but potentially without the Cc: attribute?
> 
> The message was mostly "for your information" and contained a
> status update, while no action is required or problems need to
> get resolved.
> 
> 
> virtually yours
> Gerhard Sittig
