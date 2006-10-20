Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B433567B56
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 16:29:49 +1000 (EST)
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 16:29:37 +1000
Message-Id: <1161325778.10524.158.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-20 at 01:06 -0500, Kumar Gala wrote:
> On Oct 19, 2006, at 7:39 AM, Nicolas DET wrote:
> 
> > This 'big' patch adds support for CHRP/MPC52xx based platform.  
> > Here, this is the bPlan's Efika computer (http://www.bplan-gmbh.de/ 
> > efika_spec_en.html)
> >
> > We know this patch is not totaly compliant with Documentation/ 
> > CodingStyle/.
> >
> > We would like people to comment and review it. This way we would  
> > provide a new patch with the changes required (if any) for an  
> > upcomming merge in the kernel.
> >
> > This patch has been applied on the kernel 2.6.18.1.
> >
> > Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
> > Signed-off-by: Sven Luther <sl@bplan-gmbh.de>
> 
> I think it would be extremely useful to get a dump of what the device- 
> tree looks like.  We have to be very careful to device nodes for 52xx  
> components are competed consistent between this 'CHRP' style and a  
> more embedded 52xx boards.

They should use either the /soc bus or the of_platform stuff (I'm coming
up with some reworked of_platform that can be useful to them).

Ben.
