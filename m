Return-Path: <dgibson@ozlabs.org>
Date: Thu, 2 Oct 2008 16:39:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Subject: Re: [PATCH]ppc4xx-Walnut: fixes early boot messages
Message-ID: <20081002063954.GR25598@yookeroo.seuss>
References: <200810020736.40736.niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200810020736.40736.niklaus.giger@member.fsf.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 02, 2008 at 07:36:40AM +0200, Niklaus Giger wrote:
> Inherits the baudrate from U-boot to print things like:
> Using Walnut machine description                                          
> Linux version <..>
> console [udbg0] enabled                                                                                       
Uh.. but what if you're booting from cuboot or openbios, rather than a
device-tree-aware uboot.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
