Return-Path: <lagrange@fr.oleane.com>
Received: from smtp11.clb.oleane.net (smtp11.clb.oleane.net [213.56.31.48])
	by ozlabs.org (Postfix) with ESMTP id EBE152BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 19:48:06 +1000 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Kumar Gala'" <kumar.gala@freescale.com>,
	"'Dan Malek'" <dan@embeddededge.com>
Date: Thu, 14 Oct 2004 11:49:18 +0200
Message-ID: <004401c4b1d3$1ac0df40$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <010190ED-1D8F-11D9-92E7-000393DBC2E8@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8560 problem to launch user application like /sbin/init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,


> Have you turned on emulation of FP in the kernel?
No I did not it, but with the FP emulation on, the Linux runs...
Many thanks for your help.

> > The console is mapped on SCC1 port.
> > CCSRBAR is mapped at 0xF8000000 and immr at 0xF8080000.
> I would suggest using the standard memory map the rest of
> us use for 8560.  It makes the porting lots easier.
Sure. But where can I find the standard rules ?
Are the rules dependent on each demo board like 8560_ads ?
Do the custom boots respect some rules ?

> I open 2 TLBs on memory and a big TLB for all IOs included CSSRBAR.
> How do you to this?  The linux ppc kernel already manages all
> of this mapping for you.
Right. I let the kernel configure the memory TLBs but I use
a call to io_block_mapping to open the IO space
io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);

Thanks again
Bye
Laurent
