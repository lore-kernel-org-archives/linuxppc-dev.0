Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18382.7074.69060.661720@cargo.ozlabs.ibm.com>
Date: Wed, 5 Mar 2008 15:03:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] add strncmp to PowerPC
In-Reply-To: <1204340690.15052.457.camel@pasglop>
References: <1204301097.14759.6.camel@localhost.localdomain>
	<1204340690.15052.457.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> Do we have any indication that it performs better than the C one ?

I would expect it to, given that the assembler one has two branches in
the per-byte loop compared to 3 in the C version.

Paul.
