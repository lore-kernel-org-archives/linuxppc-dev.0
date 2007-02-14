Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 10:37:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all
	DTSfiles
Message-ID: <20070214233736.GJ16279@localhost.localdomain>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
	<1171486473.20192.147.camel@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8C6@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B8C6@az33exm25.fsl.freescale.net>
Cc: paulus@samba.org, Tabi Timur-B04825 <timur@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 02:09:19PM -0700, Yoder Stuart-B08248 wrote:
>  
> 
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> > Sent: Wednesday, February 14, 2007 2:55 PM
> 
> [snip]
> 
> > > Obviously, the kernel needs a 'chosen' section, and that's 
> > why U-Boot 
> > > adds one.  And since U-Boot adds one, the DTS itself 
> > doesn't need one. 
> > > Does the 8272 never use U-Boot?
> > 
> > I'm not talking specifically about the 8272. I think we should at it
> > back to all dts's
> 
> Why do we need the chosen node in the dts files?   Is it to generalize
> the dts files for use beyond u-boot?
> 
> What meaningful properties should it have in the dts?

'interrupt-controller'

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
