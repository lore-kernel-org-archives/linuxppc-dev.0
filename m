Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D45D980C-C3F8-4418-A159-6F10708C914A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 28 Oct 2005 13:49:26 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 28, 2005, at 8:05 AM, Paul Mackerras wrote:

> If anyone has patches for arch/ppc{,64} and include/asm-ppc{,64} that
> they would like to see go upstream now that 2.6.14 is out, other than
> patches that are already in the powerpc-merge tree, please let me
> know.  I am planning to ask Linus to pull the powerpc-merge tree
> shortly, and that will probably break your patches.
>
> I think the merge tree is looking pretty good, although the merge is
> by no means complete yet.  The powermac, pseries and iseries platforms
> seem to be working fine with ARCH=powerpc.  32-bit chrp is mostly
> there but needs a bit more work.
>
> If possible, I'd like to get to the point where we can remove
> arch/ppc64 entirely by the end of the 2-week merge window for 2.6.15.

Can you merge this in:

http://patchwork.ozlabs.org/linuxppc/patch?id=2931

- kumar
