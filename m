Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 10C90DDE02
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 11:31:28 +1000 (EST)
Date: Sun, 4 May 2008 21:31:26 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: <michael@ellerman.id.au>
Subject: Re: WARNING: mutexes are preferred for single holder semaphores
Message-ID: <20080504213126.3e363f5e@lappy.seanm.ca>
In-Reply-To: <1209949615.8159.7.camel@localhost>
References: <20080504204104.7eea7618@lappy.seanm.ca>
	<1209949615.8159.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 05 May 2008 11:06:55 +1000
"Michael Ellerman" <michael@ellerman.id.au> wrote:

> On Sun, 2008-05-04 at 20:41 -0400, Sean MacLennan wrote:
> > This is a bit OT, but I got the warning in the subject from
> > checkpatch.pl for a piece of code. The code *is* using a mutex.
> > Does it actually mean I shouldn't use a mutex?
> > 
> > The code declares a global mutex:
> > 
> > 	static DECLARE_MUTEX(list_lock);
> 
> .. which is a semaphore :(  [see include/linux/semaphore.h]
> 
> I think you want DEFINE_MUTEX().
> 
> Yes, this is completely ridiculous.
> 
> cheers
> 

Ok, that fixed it, once I changed all the up and down calls :p

Thanks.

Cheers,
   Sean
