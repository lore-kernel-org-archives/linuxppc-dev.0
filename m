Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18117.22358.723442.148999@cargo.ozlabs.ibm.com>
Date: Fri, 17 Aug 2007 18:07:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575 on
	FSL boards
In-Reply-To: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> The interrupt routing in the device trees for the ULI M1575 was
> inproperly using the interrupt line field as pci function.  Fixed
> up the device tree's to actual conform for to specification and
> changed the interrupt mapping code so it just uses a static mapping
> setup as follows:

This is a big patch to be going in post -rc3.  Is it really fixing a
regression or a serious bug?

Paul.
