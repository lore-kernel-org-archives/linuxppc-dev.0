Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Fri, 25 Jan 2008 19:21:50 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Reminder: removal of arch/ppc
Message-ID: <20080125192150.4cde6fac@zod.rchland.ibm.com>
In-Reply-To: <E83C3B2F-0FC4-4248-B718-0C45B56E969A@kernel.crashing.org>
References: <E83C3B2F-0FC4-4248-B718-0C45B56E969A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Jan 2008 10:55:25 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> Just a reminder that the plan is to remove arch/ppc this summer (June  
> 2008).  The following boards still existing over in arch/ppc.  Some of  
> them have been ported over to arch/powerpc.  If you care about one of  
> these boards and its not ported speak up (it helps if you have access  
> to the board).  Also, if you know a given board is free to die of  
> bitrot let us know so we know not to worry about it:

 
> 4xx:
> 	BAMBOO

Ported (mostly)

> 	CPCI405

Doubt this will be ported.

> 	EBONY

Ported (mostly)

> 	EP405

Ported (mostly)

> 	BUBINGA
> 	LUAN

No idea on these.

> 	YUCCA

Yucca was what again?  440spe?

> 	OCOTEA

This one will be ported soon.  I have an ocotea now.

> 	REDWOOD_5
> 	REDWOOD_6

Don't have either of these.

> 	SYCAMORE

I think Mathias was working on a 405gpr port somewhere.

> 	TAISHAN
> 	WALNUT

Ported (mostly)

> 	XILINX_ML300
> 	XILINX_ML403

Grant should have these in decent shape.

josh
