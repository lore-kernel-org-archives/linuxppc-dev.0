Date: Tue, 8 Dec 1998 05:42:34 -0500 (EST)
From: "David T. McWherter" <dtm@vramp.net>
To: hagopiar@vuser.vu.union.edu
cc: Ralf Weidemann <RalfW@Scalar.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: EGCS 1.1.1 FYI 
In-Reply-To: <Pine.LNX.4.05.9812072324540.2601-200000@sequoia.hagopian.net>
Message-ID: <Pine.NEB.3.96.981208053955.15759B-100000@water.vramp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've tried compiling the mozilla code too, but it aborts due
to a failing dynamic linking call in normal startup code...
it's particularly odd, as it's trying to dlopen a file with
a name parameter of NULL, and it's not even trying to hide it
(the last code I saw had a dlopen(NULL,...).  I'm *guessing*
that on other Linux platforms, such code is well-defined, 
perhaps to use the "current executable file" to do the opening,
or something...but I'm not sure...still kinda odd to me...

-David

On Mon, 7
Dec
1998 hagopiar@vuser.vu.union.edu wrote:

> FYI, I get the same problem with glibc-2.0.104... I have an strace, last
> 50 lines are attached... No time to do anything anymore... <sigh>
> 								-Rob
> 
> On Mon, 7 Dec 1998, Ralf Weidemann wrote:
> 
> > Date: Mon, 7 Dec 1998 23:22:42 +0100 (CET)
> > From: Ralf Weidemann <RalfW@Scalar.de>
> > To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
> > Subject: Re: EGCS 1.1.1 FYI 
> > 
> > 
> > >>>>> "David" == David Edelsohn <dje@watson.ibm.com> writes:
> > >>>>> "Paul J Schinder" writes:
> >     Paul> So are Gary Thomas' patches still necessary?
> > 
> >     David> 	The trampoline patch now has become a shared library
> >     David> compatibility issue for glibc-1.99 support.  It only is
> >     David> necessary until LinuxPPC cuts over to glibc-2.1 which will
> >     David> require other binary incompatible changes at the same time.
> > 
> > Can someone clarify where the problem is exact with native
> > egcs and libc-1.99 ? I use egcs-1.1.1 since the weekend and
> > it seems to work fine. I had no trouble to build some shared
> > lib stuff like in the latest jade or sgml-tools. This packages
> > didn't compile with older version I tried (also Gary's egcs-1.1b),
> > but that were generell compiler issues, I think.
> > 
> > But on the other side I also tried to run the SeaMonkeyBrowser
> > (Mozilla) from recent cvs-sources. Building went fine, but the
> > beast didn't run. I get only a simple "Aborted" message on the
> > console and it seems to crash somewhere in the startup code.
> > So maybe this is somehow related ?
> > 
> > Had someone luck to run a recent version of Mozilla at all on
> > LinuxPPC ?
> > 
> > Thanks,
> > Ralf
> > 
> > 
> > 
> > 
> 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       David T. McWherter     dtm@waterw.com


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
