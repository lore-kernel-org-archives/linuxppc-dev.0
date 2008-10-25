Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18690.35483.845880.696901@cargo.ozlabs.ibm.com>
Date: Sat, 25 Oct 2008 13:55:23 +1100
From: Paul Mackerras <paulus@samba.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [RFC] a little disassembly infrastructure
In-Reply-To: <1224867546.9634.42.camel@localhost.localdomain>
References: <1224867546.9634.42.camel@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard writes:

> I've also found xmon's ppc-opc.c. That parses the opcode and operands,
> so could use some shared macros.

That's a direct copy from GNU binutils.  I'm reluctant to modify it
because then maintenance becomes more than just copying in the latest
version.

Paul.
