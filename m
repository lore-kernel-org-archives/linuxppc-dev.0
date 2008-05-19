Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18482.2082.900892.368978@cargo.ozlabs.ibm.com>
Date: Tue, 20 May 2008 09:07:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/4] minor fixes for 2.6.26
In-Reply-To: <0B367446-4628-4633-BF66-A0007BD9A98B@kernel.crashing.org>
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
	<0B367446-4628-4633-BF66-A0007BD9A98B@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> > Kumar Gala (4):
> >      lmb: Fix compile warning
> >      [POWERPC] Remove generated files on make clean

I think that adding zImage.* to clean-files is a bad idea, because we
have zImage.lds.S, zImage.coff.lds.S and zImage.ps3.lds.S in
arch/powerpc/boot that we don't want deleted.  It would be OK for
compiling with a separate object directory but would be bad for
compiling in the source directory.

Paul.
