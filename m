Date: Fri, 4 Oct 2002 11:55:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Porter <porter@cox.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Remove ocp-proc.c
Message-ID: <20021004015551.GC1933@zax>
References: <20021003062159.GA6160@zax> <20021003075753.B4643@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021003075753.B4643@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 03, 2002 at 07:57:53AM -0700, Matt Porter wrote:
>
> On Thu, Oct 03, 2002 at 04:21:59PM +1000, David Gibson wrote:
> > This patch completely removes drivers/ocp/ocp-proc.c from 2.5, along
> > with all references to it - it's been terminally broken for some time
> > now.  Shall I commit this to linuxppc-2.5?
>
> I think so.  In a previous thread you brought this up and I think
> moving some of the provided infos into driverfs at a later point is
> the goal, correct?  At any rate, it's the Right Thing To Do(tm).

Done.

Some of the info - the actual list of devices/drivers - is already in
driverfs, simply by virtue of the fact that we call device_register()
and friends.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
