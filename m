Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 10:54:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/4] minor fixes for 2.6.26
Message-ID: <20080520005401.GD22279@yookeroo.seuss>
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
	<0B367446-4628-4633-BF66-A0007BD9A98B@kernel.crashing.org>
	<18482.2082.900892.368978@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18482.2082.900892.368978@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 09:07:14AM +1000, Paul Mackerras wrote:
> Kumar Gala writes:
> 
> > > Kumar Gala (4):
> > >      lmb: Fix compile warning
> > >      [POWERPC] Remove generated files on make clean
> 
> I think that adding zImage.* to clean-files is a bad idea, because we
> have zImage.lds.S, zImage.coff.lds.S and zImage.ps3.lds.S in
> arch/powerpc/boot that we don't want deleted.  It would be OK for
> compiling with a separate object directory but would be bad for
> compiling in the source directory.

Arguably this suggests we should rename either the lds files or the
zImages so that we *can* get a pattern to match.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
