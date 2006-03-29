Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17450.2061.510951.479016@cargo.ozlabs.ibm.com>
Date: Wed, 29 Mar 2006 15:07:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg Smith <gsmith@nc.rr.com>
Subject: Re: [OT] ppc64 serialization problem
In-Reply-To: <1143597506.3075.53.camel@localhost.localdomain>
References: <1143597506.3075.53.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greg Smith writes:

> On rare occasions, values A and B will differ!  In the examples that I
> have seen, there is contention with `lock'.  This phenomenon does not
> occur on ppc32 or a number of other architectures that we support.

I would be interested to see the assembler code being generated for
your code snippets.

Paul.
