Message-ID: <387FA489.1F31B1AA@jlc.net>
Date: Fri, 14 Jan 2000 17:34:49 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Grant Erickson <grant@lcse.umn.edu>
CC: Charles Lepple <clepple@mitre.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: *_find_end_of_memory Mach Dep?
References: <Pine.SGI.4.10.10001141504430.254646-100000@brule.borg.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Grant Erickson wrote:

> On Fri, 14 Jan 2000, Charles Lepple wrote:
> > When I converted some code to the ppc_md interface, I seem to remember a
> > few cases where I couldn't do it that way because the ppc_md structure
> > was not completely filled out. It can get to be a catch-22 -- there has
> > to be one messy function.


I already checked this before I sent my reply, and it should work fine.


> So, it seems reasonable that "identify_machine" remains the messy
> function and MMU_init could be cleaned up somewhat.


It only looks messy because you haven't seen it grow over the years :-).
I think it is aging rather gracefully.....


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
