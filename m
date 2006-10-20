Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp-msa-out01.orange.fr (unknown [193.252.23.120])
	by ozlabs.org (Postfix) with ESMTP id B254D67B6D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 16:32:47 +1000 (EST)
Date: Fri, 20 Oct 2006 08:29:29 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Message-ID: <20061020062929.GC14390@powerlinux.fr>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, tnt@246tNt.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, 2006 at 01:06:14AM -0500, Kumar Gala wrote:
> 
> On Oct 19, 2006, at 7:39 AM, Nicolas DET wrote:
> 
> >This 'big' patch adds support for CHRP/MPC52xx based platform.  
> >Here, this is the bPlan's Efika computer (http://www.bplan-gmbh.de/ 
> >efika_spec_en.html)
> >
> >We know this patch is not totaly compliant with Documentation/ 
> >CodingStyle/.
> >
> >We would like people to comment and review it. This way we would  
> >provide a new patch with the changes required (if any) for an  
> >upcomming merge in the kernel.
> >
> >This patch has been applied on the kernel 2.6.18.1.
> >
> >Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
> >Signed-off-by: Sven Luther <sl@bplan-gmbh.de>
> 
> I think it would be extremely useful to get a dump of what the device- 
> tree looks like.  We have to be very careful to device nodes for 52xx  
> components are competed consistent between this 'CHRP' style and a  
> more embedded 52xx boards.

Well, the efika is a CHRP board, and thus more akin to the pegasos or IBM
boxes than the embedded 52xx boards with regard to the device trees. Nico will
provide you an lsprop output.

> Some high level comments:
> 2. PIC code needs to be updated for new interrupt model (as well as  
> remove of pt_regs)

Notice that the efika does not have the interrupt tree bindings in the
firmware. I implemented those on pegasos last month, but linux refused to
boot, and i am currently waiting for comments from benh on the lsprop output.

Friendly,

Sven Luther
