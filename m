Date: Mon, 11 Aug 2003 10:31:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BK problems with linuxppc-2.5
Message-ID: <20030811173102.GD807@ip68-0-152-218.tc.ph.cox.net>
References: <E19lS18-0003Ng-00@source.mvista.com> <1060436322.16233.52.camel@hermes> <20030811171247.GC807@ip68-0-152-218.tc.ph.cox.net> <1060622253.31273.271.camel@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1060622253.31273.271.camel@hermes>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 11, 2003 at 11:17:33AM -0600, Gary Thomas wrote:
> On Mon, 2003-08-11 at 11:12, Tom Rini wrote:
> > On Sat, Aug 09, 2003 at 07:38:43AM -0600, Gary Thomas wrote:
> >
> > >
> > > I've been unable to access this repository [for days].
> > >
> > >  [gthomas@hermes tmp]$ bk clone bk://source.mvista.com/linuxppc-2.5 linuxppc-2.5
> > >   ERROR-Can't get read lock on the repository.
> > >
> > > Any ideas/help?
> >
> > This should be fixed now.
>
> Yes, thanks.  Any feedback what was stuck?  (I tried it just a few
> hours ago and it was still broken, so you obviously did something)

It was a local permissions issue.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
