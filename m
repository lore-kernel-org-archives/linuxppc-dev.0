Return-Path: <rmcguire@videopresence.com>
Received: from smtpout10-04.prod.mesa1.secureserver.net
	(smtpout10-04.prod.mesa1.secureserver.net [64.202.165.238])
	by ozlabs.org (Postfix) with SMTP id 7EE67DDECE
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 16:32:57 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
	<0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
	<000701c7457a$d180e300$6405a8c0@absolut>
	<183E66A5-E983-4D17-96E9-2EEAE6FDF7B6@kernel.crashing.org>
	<000f01c74587$10bc5cf0$6405a8c0@absolut>
	<1546691E-0CCF-41C9-8B8A-7C6326CEEF7E@kernel.crashing.org>
	<000301c7458b$b9eb1330$6405a8c0@absolut>
	<829261C6-F534-4B85-A04D-8D280E46B2CF@kernel.crashing.org>
	<000401c74591$8a3a4ec0$6405a8c0@absolut>
	<BC5846DA-A217-43B7-8060-6EA05CC62913@kernel.crashing.org>
	<000801c7460d$211e46e0$6405a8c0@absolut>
	<974C77BD-19A0-4843-8E7B-3B430DB4ADE9@kernel.crashing.org>
	<001101c74629$28797380$6405a8c0@absolut>
	<AF782BFC-5262-462B-A522-8F685DC59158@kernel.crashing.org>
	<001001c74674$b17bf4f0$6405a8c0@absolut>
	<567B131D-57F5-4972-AF09-5373D041368C@kernel.crashing.org>
	<000b01c746cf$35accc40$6405a8c0@absolu
	t> <CBE9C97B-2A34-4D56-B7E8-F46728EF29F6@kernel.crashing.org>
Subject: RE: 8360E - PCI / DTC Blob Setup
Date: Fri, 2 Feb 2007 21:32:44 -0800
Message-ID: <000701c74754$bbd23910$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <CBE9C97B-2A34-4D56-B7E8-F46728EF29F6@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> On Feb 2, 2007, at 7:36 AM, Russell McGuire wrote:
> 
> >
> > Well I am getting smarter on this:
> >
> > I have read through the PCI Bridge Specs and found another issue
> > that might
> > have been causing a problem with the IDSEL lines. Unless you are
> > interested
> > I'll forgo that explanation and just go with fact that I have
> > changed the
> > IDSEL mappings to be legal when they are issued from the 83xx.
> >
> > I have changed the IDSELs to be as follows, does this look correct?
> 
> Not sure, I'm a little confused as to how exactly things are wired on
> your board.  It would seem like you have 2 P2P bridges connected to
> the processor.  Behind one bridge is 2 slots and behind the second is
> 1 slot?

Absolutely correct, I probably should send a picture. :-) But yes, the CPU
host bridge is directly connected to a DUAL P2P bridge chip. There are no
SLOTS on BUS 0. The P2P then provides BUS 1 and BUS 2. I did this in the
design to allow slower 33Mhz cards to operate in the system without slowing
down the 66Mhz cards <i.e. a sound card or USB card, but still being able to
run a VGA card or video capture card at high speed>.

BUS 1 has two slots, and BUS 2 has one slot, for a total of three.

I would be more than happy to send a 2 page PDF file of the schematic. This
design obviously hasn't been proofed yet. Though it 'seems' to almost work.

-Russ
