Return-Path: <michael@ellerman.id.au>
Date: Thu, 14 Feb 2013 09:37:18 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoff@infradead.org>
Subject: Re: PS3 platform is broken on Linux 3.7.0
Message-ID: <20130213223718.GA17158@concordia>
References: <1355488506.55692113@f147.mail.ru> <1360740779.28936.20.camel@clam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360740779.28936.20.camel@clam>
Cc: Phileas Fogg <phileas-fogg@mail.ru>, cbe-oss-dev@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2013 at 11:32:59PM -0800, Geoff Levand wrote:
> Hi,
> 
> On Fri, 2012-12-14 at 16:35 +0400, Phileas Fogg wrote:
> > I wanted to bring to your attention the fact that the PS3 platform is broken on Linux 3.7.0.
> 
> > So i cloned the Linux powerpc GIT repository and tried to find out which commits broke the PS3 platform.
> 
> > ---------------------------------------------------------------------------------------------
> > 
> > commit 407821a34fce89b4f0b031dbab5cec7d059f46bc
> > Author: Michael Ellerman <michael@ellerman.id.au>
> > Date:   Fri Sep 7 15:31:44 2012 +0000
> > 
> >     powerpc: Initialise paca.data_offset with poison
> 
> I did a little more work on this, and it seems the change below
> will fix the problem introduced by Michael's change.  I can only
> guess we need to use udbg_printf() here.  I'll look at it some more
> as I have time.

Have you tried with the patch I posted yesterday?

cheers
