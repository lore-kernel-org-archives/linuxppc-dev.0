Return-Path: <paulus@ozlabs.org>
Date: Wed, 2 Jun 2010 16:00:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc: Emulate most load and store instructions
	in emulate_step()
Message-ID: <20100602060003.GB24509@drongo>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100602052502.GA2451@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100602052502.GA2451@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 02, 2010 at 10:55:02AM +0530, K.Prasad wrote:
> On Thu, May 20, 2010 at 10:49:55PM +1000, Paul Mackerras wrote:
> > This extends the emulate_step() function to handle most of the load
> > and store instructions implemented on current 64-bit server processors.
> > The aim is to handle all the load and store instructions used in the
> > kernel, so this handles the Altivec/VMX lvx and stvx and the VSX
> > lxv2dx and stxv2dx instructions (implemented in POWER7).
> > 
> 
> Can the emulate_step() function be used on BookIII E processors as well
> (arch/powerpc/kernel/kprobes.c invokes it irrespective of the host
> processor though)?

I expect it can.  I haven't checked what extra things I'd need to add
for Book 3E though.  I also want to use it on classic 32-bit as well.

Paul.
