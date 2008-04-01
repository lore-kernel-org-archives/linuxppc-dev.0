Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18418.4984.671485.346817@cargo.ozlabs.ibm.com>
Date: Tue, 1 Apr 2008 21:50:32 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 04/11 v2] [POWERPC] Remove and replace uses of
	PPC_MEMSTART with memstart_addr
In-Reply-To: <1207015715-31496-5-git-send-email-galak@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-3-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-4-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-5-git-send-email-galak@kernel.crashing.org>
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

> For the sub-arches that support relocatable interrupt vectors (book-e) its
> reasonable to have memory start at a non-zero physical address.  For those
> cases use the variable memstart_addr instead of the #define PPC_MEMSTART
> since the only uses of PPC_MEMSTART are for initialization and in the
> future we can set memstart_addr at runtime to have a relocatable kernel.

In those cases, is it still true that the kernel sits at the start of
the usable memory, or might there be usable memory before _stext?
In other words, is PAGE_OFFSET == KERNELBASE still true or not?

Paul.
