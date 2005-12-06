Return-Path: <maj1224@yahoo.com>
Received: from web33505.mail.mud.yahoo.com (web33505.mail.mud.yahoo.com
	[68.142.206.154]) by ozlabs.org (Postfix) with SMTP id 64D9A68871
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 03:48:53 +1100 (EST)
Message-ID: <20051206164212.82779.qmail@web33505.mail.mud.yahoo.com>
Date: Tue, 6 Dec 2005 08:42:12 -0800 (PST)
From: Matt Jerdonek <maj1224@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Denx vs kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm looking at embedding linux into a PowerPC-based
system.  I found the DENX website to be very helpful,
but I'm struggling to understand a few items:

1) The source from kernel.org appears to have support
for the powerpc (arch/powerpc/8xx_io).  But when using
'make xconfig' I cannot select PowerPC from the list
of processors.  Is this just a limitation on the the
configuration utility?

2) What is the difference between the sources on DENX
and kernel.org?  Are there other places where PPC
linux kernel source is stored?  I'm not opposed to
using the DENX source, I'm just trying to understand
it.

3) I've used eCos before and I'm familiar with
RedBoot.  Is there a compelling reason to use U-Boot
over RedBoot?  For example, I think U-boot contains an
NFS client while RedBoot does not.  Is this important?

Thanks in advance,
-- Matt


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 
