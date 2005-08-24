Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17163.51700.805599.487962@cargo.ozlabs.ibm.com>
Date: Wed, 24 Aug 2005 11:14:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Al Viro <viro@www.linux.org.uk>
In-Reply-To: <E1E7gbC-0007Bf-NF@parcelfarce.linux.theplanet.co.uk>
References: <E1E7gbC-0007Bf-NF@parcelfarce.linux.theplanet.co.uk>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (20/43) Kconfig fix (ppc32 SMP dependencies)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Al Viro writes:

> ppc SMP is supported only for 6xx/POWER3/POWER4 - i.e. ones that have
> PPC_STD_MMU.  Dependency fixed.
> 
> Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

Acked-by: Paul Mackerras <paulus@samba.org>
