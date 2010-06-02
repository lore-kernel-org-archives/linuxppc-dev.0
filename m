Return-Path: <paulus@ozlabs.org>
Date: Wed, 2 Jun 2010 21:33:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver
	XXII
Message-ID: <20100602113316.GA17061@brick.ozlabs.ibm.com>
References: <20100528063924.GA8679@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100528063924.GA8679@in.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 28, 2010 at 12:09:24PM +0530, K.Prasad wrote:

> 	Please find a new set of patches that have the following changes.

Thanks.  There are a couple of minor things still remaining (dangling
put_cpu in arch_unregister_hw_breakpoint, plus I don't think reusing
current->thread.ptrace_bps the way you did in patch 5/5 is a good
idea), but I think at this stage I'll put them in a tree together
with my latest emulate_step version and then push them to Ben H and/or
Ingo Molnar once I've done some testing.

Paul.
