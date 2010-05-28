Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: ananth@in.ibm.com
Subject: Re: [RFC PATCH] powerpc: Emulate nop too
In-reply-to: <20100528041645.GB25946@in.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100527141203.GA20770@in.ibm.com> <23979.1275013723@neuling.org>
	<20100528041645.GB25946@in.ibm.com>
Date: Fri, 28 May 2010 14:23:30 +1000
Message-ID: <7278.1275020610@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <20100528041645.GB25946@in.ibm.com> you wrote:
> On Fri, May 28, 2010 at 12:28:43PM +1000, Michael Neuling wrote:
> > 
> > 
> > In message <20100527141203.GA20770@in.ibm.com> you wrote:
> > > Hi Paul,
> > > 
> > > While we are at it, can we also add nop to the list of emulated
> > > instructions?
> > > 
> > > Ananth
> > > ---
> > > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > > 
> > > Emulate ori 0,0,0 (nop).
> > > 
> > > The long winded way is to do:
> > > 
> > >         case 24:
> > >                 rd = (instr >> 21) & 0x1f;
> > >                 if (rd != 0)
> > >                         break;
> > >                 rb = (instr >> 11) & 0x1f;
> > >                 if (rb != 0)
> > >                         break;
> > 
> > Don't we just need rb == rd?
> 
> Sure. But for this case, just checking against the opcode seems simple
> enough.

Simple, sure.  You could not emulate anything and remove the code
altogether.  That would be truly simple. :-P

Why not eliminate as much as possible?

Anyway, sounds like paulus as a better solution.

Mikey
