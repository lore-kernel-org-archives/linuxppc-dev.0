Return-Path: <paulus@ozlabs.org>
Date: Thu, 15 Nov 2012 10:02:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] TTY: hvc_console, fix port reference count going to zero
 prematurely
Message-ID: <20121114230257.GA17092@drongo>
References: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
 <50A36844.7080207@suse.cz> <1352897279.23412.22.camel@pasglop>
 <20121114150901.GA2371@kroah.com>
 <1352926097.23412.24.camel@pasglop>
 <20121114205407.GA7937@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121114205407.GA7937@kroah.com>
Cc: linuxppc-dev@ozlabs.org, Jiri Slaby <jslaby@suse.cz>, anton@samba.org,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 14, 2012 at 12:54:07PM -0800, Greg KH wrote:
> On Thu, Nov 15, 2012 at 07:48:17AM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2012-11-14 at 07:09 -0800, Greg KH wrote:
> > > > So who's merging it ?
> > > 
> > > Give me a chance to at least wake up please :)
> > 
> > Sure ;-) Just asking since I'm about to cook up a powerpc batch :-)
> 
> It's now in my tree, and will get to Linus in time for 3.7.

Turns out I stuffed up the commit message a bit, I talk about kref_put
and tty_kref_put when I should be talking about tty_port_put.  If
there is still a chance to update the commit message, that would be
good.  The patch itself is correct.

> > > I will.
> > 
> > Thanks ! It should go into stable 3.6 as well.
> 
> Why?  The offending patch didn't show up until 3.7-rc1.

Yes.  I had thought it was in 3.6 but it isn't.

Paul.
