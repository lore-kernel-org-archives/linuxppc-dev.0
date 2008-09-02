Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 35954DE0D6
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 07:22:51 +1000 (EST)
Date: Tue, 2 Sep 2008 16:30:44 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Reserve syscall number 319
Message-ID: <20080902213044.GA11416@lixom.net>
References: <20080902054941.77DA3DDDF0@ozlabs.org>
	<20080902180605.GA8240@lixom.net>
	<1220389575.13010.149.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220389575.13010.149.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 03, 2008 at 07:06:15AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2008-09-02 at 13:06 -0500, Olof Johansson wrote:
> > On Tue, Sep 02, 2008 at 03:48:45PM +1000, Benjamin Herrenschmidt wrote:
> > > Some stuff I'm working on that isn't released yet needs
> > > a syscall number but I can't say what it's for until I
> > > get permission to release it :-)
> > > 
> > > In the meantime, it would be nice if a number could be set
> > > aside so the tools being developped to use that stuff don't
> > > all need to be updated when things are eventually released.
> > > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > ---
> > > 
> > > I wonder if I'll get hanged for that one :-)
> > 
> > Yes. Merge your code or live with the pain of things changing
> > underneath. Period.
> 
> Pain isn't for me :-) It's for those writing userspace stuff based on
> my kernel changing all the time :-)

Lame excuse. Merge the code.


-Olof
