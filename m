Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18418.2460.594352.712502@cargo.ozlabs.ibm.com>
Date: Tue, 1 Apr 2008 21:08:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
In-Reply-To: <1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
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

> Normally we assume kernel images will be loaded at offset 0. However
> there are situations, like when the kernel itself is running at a non-zero
> physical address, that we don't want to load it at 0.
> 
> Allow the wrapper to take an offset.  We use this when building u-boot images.

This makes it a bit harder to build a kernel and then wrap it later
on, since one would have to know what -m value to give.  Would it
possible for either the wrapper script or mkimage to peek in the ELF
header of the vmlinux to work out what physical address to use?

Paul.
