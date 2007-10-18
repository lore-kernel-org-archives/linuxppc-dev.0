Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18199.60025.563689.10810@cargo.ozlabs.ibm.com>
Date: Fri, 19 Oct 2007 09:21:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
In-Reply-To: <200710181108.19413.yur@emcraft.com>
References: <200710181108.19413.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yuri Tikhonov writes:

> The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
> The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
> built using the modified version of binutils, where the MAXPAGESIZE 
> definition is set to 0x40000 (as opposite to standard 0x10000).

Have you measured the performance using a 64kB page size?  If so, how
does it compare with the 256kB page size?

The 64kB page size has the attraction that no binutils changes are
required.

Paul.
