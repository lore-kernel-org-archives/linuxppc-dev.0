Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 03BCCDDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 01:04:08 +1100 (EST)
Message-ID: <45D316CD.9070901@freescale.com>
Date: Wed, 14 Feb 2007 08:03:57 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <1171409687840-git-send-email-timur@freescale.com>	
	<1171411075.20192.116.camel@localhost.localdomain>	
	<45D29AE5.7090004@freescale.com>	
	<1171430877.20192.133.camel@localhost.localdomain>	
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
In-Reply-To: <1171431334.20192.138.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>> I just don't understand why it's okay to leave it there.
> 
> To make sure there is one. I suspect kernel bits might get upset if it's
> absent.

That's not what I meant.  What I don't understand is: what's so special 
about the 8272 that its DTS should have a 'chosen' section, but no other 
DTS needs one?

Obviously, the kernel needs a 'chosen' section, and that's why U-Boot 
adds one.  And since U-Boot adds one, the DTS itself doesn't need one. 
Does the 8272 never use U-Boot?
