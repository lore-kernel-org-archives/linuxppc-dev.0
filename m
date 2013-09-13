Return-Path: <michael@ellerman.id.au>
Date: Fri, 13 Sep 2013 15:10:30 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pmac: Early debug output on screen on 64-bit macs
Message-ID: <20130913051029.GA5411@concordia>
References: <1374718352.6142.48.camel@pasglop>
 <1374720597.6142.49.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374720597.6142.49.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 12:49:57PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-25 at 12:12 +1000, Benjamin Herrenschmidt wrote:
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -10,7 +10,7 @@
> >   *      2 of the License, or (at your option) any later version.
> >   */
> >  
> > -#undef DEBUG
> > +#define DEBUG
> 
> Ooops... sent the wrong version. Will send an updated one later,
> if there are no other comments.

Looks like you merged the version with #define DEBUG.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/setup_64.c#n13


cheers
