Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18118.13541.470351.661964@cargo.ozlabs.ibm.com>
Date: Sat, 18 Aug 2007 09:53:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575 on
	FSL boards
In-Reply-To: <D6CFE4FC-5112-450B-B13F-2DC40165EB71@kernel.crashing.org>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<18117.22358.723442.148999@cargo.ozlabs.ibm.com>
	<D6CFE4FC-5112-450B-B13F-2DC40165EB71@kernel.crashing.org>
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

> Its a regression in that the ULI M1575 doesn't really work properly  
> on some of these boards in certain situations.

Well, "it doesn't work" isn't of itself a regression, a regression is
"it used to work and now it doesn't".

In any case the lateness x largeness product (LxL) of that patch is a
bit too high.  Is there a simpler way to fix it that doesn't involve
moving all that code around?

Paul.
