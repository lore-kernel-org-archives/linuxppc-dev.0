Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18206.32494.209309.594078@cargo.ozlabs.ibm.com>
Date: Wed, 24 Oct 2007 09:08:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
In-Reply-To: <6c38f6dc60553ae158e4d3094b879e10@kernel.crashing.org>
References: <200710181108.19413.yur@emcraft.com>
	<18199.60025.563689.10810@cargo.ozlabs.ibm.com>
	<E0BC0C69-03B1-4F7A-9DEC-0EA9DAC92FB7@kernel.crashing.org>
	<200710222012.20316.yur@emcraft.com>
	<6c38f6dc60553ae158e4d3094b879e10@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> If I understand you correctly, the only problem with existing binaries
> is that the ELF segments are aligned to 64kB, but not necessarily to
> 256kB.  Couldn't you handle this as a special case, for example by
> mapping the "ends" of such an unaligned segment with normal 4kB pages?

That's very hard to do if the system page size is 256k, since the
kernel has no support for mapping parts of pages.

Paul.
