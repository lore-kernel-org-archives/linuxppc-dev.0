Return-Path: <mmporter@cox.net>
Date: Tue, 1 Nov 2005 06:22:50 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051101062250.A28639@cox.net>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
	<20051028103041.B15268@cox.net>
	<17255.737.832440.137041@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17255.737.832440.137041@cargo.ozlabs.ibm.com>;
	from paulus@samba.org on Tue, Nov 01, 2005 at 04:53:37PM +1100
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 01, 2005 at 04:53:37PM +1100, Paul Mackerras wrote:
> Matt Porter writes:
> 
> > Ok, we have a set of 4xx patches that I plan to send to Andrew.
> > They are some existing 4xx SoC/board updates as well as a new
> > SoC/board. They are obviously mostly confined to the 4xx code paths
> > but there's likely conflicts in changes to Makefiles, etc.
> > 
> > Would you prefer these going upstream before or after the 
> > powerpc-merge pull?
> 
> Did you send them yet?  Linus has pulled the powerpc-merge tree, as
> I'm sure you've noticed.

Yes I did. I saw the merge go into mainline and rebased what was
necessary off of that.  Andrew now has them queued up for Linus so
we are set. BTW, we're starting to look at merging 4xx to arch/powerpc/
now.

-Matt
