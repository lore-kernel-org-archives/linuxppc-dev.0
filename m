Date: Thu, 23 Sep 1999 18:36:32 -0500
From: erik cameron <cameron@senta.uchicago.edu>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: Stephen Travis Pope <stp9@cornell.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC equivalent of LocationManager ???
Message-ID: <19990923183632.L11547@senta.uchicago.edu>
References: <37EA6709.DAD02422@cornell.edu> <37EA898C.4DD42F70@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37EA898C.4DD42F70@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



in my experience, the best way to do this is to just write a quick and
dirty shell script to take care of network setup; maybe that's the solaris admin
in me talking...  :)  it just seems that the required parameters are simple
enough, and linuxconf is screwy enough, that it winds up being easier to roll your
own.  and the same script can run all of your configurations, and prompt you at boot, 
etc...  just my $0.02.  And yeah, if I had a copy of the scripts i've written, I'd
attatch them, but alas, I suck.  :|

-e

On Thu, Sep 23, 1999 at 10:11:56PM +0200, Martin Costabel wrote:
> 
> Stephen Travis Pope wrote:
> > 
> > Hello all,
> > 
> > I use LinuxPPC on a Lombard/Bronze PowerBook and *love* it. I also move
> > between several sites (home, office, campus, etc.) and (in the Mac
> > world) have several LocationManager setups for networking (PPP vs.
> > 10BaseT connection, different IP addresses, domains, name servers,
> > etc.).
> > 
> > Does anyone have a set of scripts for managing multiple sets of /etc/*
> > config files for simulating LocationManager on LinuxPPC???
> 
> There is the possibility to define different profiles in linuxconf. I
> haven't tested this, and I haven't heard from anyone that has. Mostly
> linuxconf haters online lately..
> 
> --
> Martin

-- 
erik cameron  unix systems administrator
jfi/mrsec @ the university of chicago
e-cameron@uchicago.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
