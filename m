Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 31202DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jun 2007 00:33:07 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so265934wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 07:33:06 -0700 (PDT)
Message-ID: <fa686aa40706130733u51aaf7der3eedc5a36f61a795@mail.gmail.com>
Date: Wed, 13 Jun 2007 08:33:05 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "phil culler" <phil.culler@gmail.com>
Subject: Re: [linux-usb-devel] [PATCH 6/6] [C67x00] Merge c67x00-hub.c into
	c67x00-hcd.c
In-Reply-To: <a94a91430706130659v2ac10f82h355c0bbb4fd6f2cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
	<11816893492706-git-send-email-grant.likely@secretlab.ca>
	<11816893493783-git-send-email-grant.likely@secretlab.ca>
	<1181689350166-git-send-email-grant.likely@secretlab.ca>
	<11816893503814-git-send-email-grant.likely@secretlab.ca>
	<11816893511659-git-send-email-grant.likely@secretlab.ca>
	<87645sieew.fsf@p4.be.48ers.dk>
	<fa686aa40706130554l36fefa13w4e2b1957a9fc5288@mail.gmail.com>
	<a94a91430706130659v2ac10f82h355c0bbb4fd6f2cb@mail.gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/13/07, phil culler <phil.culler@gmail.com> wrote:
>
> On 6/13/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 6/12/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> > > >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca > writes:
> > >
> > > Hi,
> > >
> > >  Grant> Rather than c67x00-hub.c being compiled seperately, the
> > >  Grant> original code had c67x00-hub.c *included* by c67x00-hcd.c.
> > >  Grant> This is a very bad idea.  Simplest solution is to merge the
> > >  Grant> two files into one and be done with it.
>
>
> > Hi Guys,
> > I'm currently implementing the gadget API for the c67x00 (specifically
> CY7C63200) and have several questions.
> >
> > 1. Are you aware of any others working on the gadget API for this driver?

Other than the skeleton that Peter wrote, No.  However, Peter has done
much of the low level work that is shared between HCD and Gadget.  You
need to look at his patchset.

http://thread.gmane.org/gmane.linux.usb.devel/53285

> > 2. I'm doing this on an embedded device (Xilinix/PPC) with no hardware DMA
> and on top of MontaVista 4.01 (2.6.10-kernel). I'd prefer to develop on a
> current kernel using something like a PCI card. Can you recommend a
> reasonably-priced development platform for the c67x00?

Hmm, I don't know.  I don't know of any.  I'm doing all my devel on an
ml403.  Check with Cypress.  I think they have an ARM based
development kit for the c67x00.

> > 3. Any suggestions about preventing additional ugly code? I'm adding the
> bulk of the API in c67x00-udc.c

Yes, post your patches to the list so so others can comment.  That's
the best way to find out if you're taking a bad approach.  Also,
follow the Linux kernel coding convention and run your code through
scripts/Lindent

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
