Date: Fri, 8 Dec 2000 12:24:44 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: diekema_jon <diekema@bucks.si.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
In-Reply-To: <m144RWF-001SzYC@bucks>
Message-ID: <Pine.GSO.4.21.0012081220100.24199-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 8 Dec 2000, diekema_jon wrote:

> > I am trying to do some kernel profiling on my EST8260 to determine the
> > bottle neck in TCP and UDP thruput, but I can't seem to get any profile
> > information.
>
I figured it out.  It was a "corrupt" System.map file.  My Solaris cross
environment does not have all the extensions that Linux's Makefiles
expect.  grep was the culpret this time.

I am just a rebel that wants to create the cross environment myself
instead of using Monta Vista's.  Every so often I find another problem.

> What version of Linux are you using?  I have tried the LTT, Linux
> Trace Toolbox under 2.4.0-test11.  LTT tracks a large number of
> events, so it may give you a better handle as to what is happening
> when.
>
Thanks.  I have it, but I haven't figured it all out yet.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
