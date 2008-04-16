Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18437.16961.768567.782611@cargo.ozlabs.ibm.com>
Date: Wed, 16 Apr 2008 10:03:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/12] [POWERPC] 85xx: Add support for relocatble kernel
	(and booting at non-zero)
In-Reply-To: <C2C3AFC1-7527-4571-8E21-3EB5904695DE@kernel.crashing.org>
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-5-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-6-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-7-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-8-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-9-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-11-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-12-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-13-git-send-email-galak@kernel.crashing.org>
	<18436.35348.316368.332336@cargo.ozlabs.ibm.com>
	<C2C3AFC1-7527-4571-8E21-3EB5904695DE@kernel.crashing.org>
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

> > What happens if CONFIG_KERNEL_START != CONFIG_PAGE_OFFSET and the
> > kernel is loaded at some address != CONFIG_PHYSICAL_START?
> 
> Assuming its not a CONFIG_RELOCATABLE kernel than bad things.  Is  
> there some concern you have here?

No, I meant if it is a CONFIG_RELOCATABLE kernel.

BTW, the various bits of discussion we've about this stuff would make
good material for the patch description.

Paul.
