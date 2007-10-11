Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 8945ADDF5B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 14:18:51 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so501104wag
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 21:18:50 -0700 (PDT)
Message-ID: <fa686aa40710102118p3e62d06eqff8db252772eb58c@mail.gmail.com>
Date: Wed, 10 Oct 2007 22:18:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
In-Reply-To: <20071011040622.GE14873@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
	<1192048682.5534.92.camel@localhost.localdomain>
	<20071011013817.GB14873@localhost.localdomain>
	<fa686aa40710101925x6b005aa7paaeb072ba492c81f@mail.gmail.com>
	<20071011040622.GE14873@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> On Wed, Oct 10, 2007 at 08:25:36PM -0600, Grant Likely wrote:
> > On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> > > We've used 'cell-index' for similar purposes on other 4xx.
> >
> > Unfortunately, 'cell' has been used in the sense of a logic cell in an
> > SoC.  In the case of the SystemACE, it is an external chip.
> >
> > What about "device-number"?
>
> Ok, I misunderstood.  If it's not on chip, what significance does this
> serial number have?  Where would a driver need it?

If there were 2 systemace devices on board; one attached to a CF slot
labeled "1" and the other to one labeled "2".  :-)  Same problem as
lining up serial device files to physical port numbers.

The driver doesn't technically need it, but the information does need
to flow through to the creation of logically numbered device files.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
