Message-ID: <19990522020440.49547@ibrium.se>
Date: Sat, 22 May 1999 02:04:40 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Mac-on-Linux
References: <19990519235050.60265@ibrium.se> <Pine.LNX.3.96.990519210752.5706A-100000@EdMcMan.Dyn.Ez-Ip.Net> <19990520192459.17170@ibrium.se> <19990520171823.A409@jasons.dyn.kpn.cx> <87zp2ysaku.fsf@hades.nocrew.net> <19990521203719.44590@ibrium.se> <87so8qp44p.fsf@hades.nocrew.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87so8qp44p.fsf@hades.nocrew.net>; from Stefan Berndtsson on Fri, May 21, 1999 at 10:19:34PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 21, 1999 at 10:19:34PM +0200, Stefan Berndtsson wrote:
> > Ok.. this seems to help a lot. It no longer panics, and I've
> got a rom-image for my performa 6400, but when I tell it to
> start with Meta-G, it just sits there.
> 
> This machine has a valkyrie graphics card, and since 
> platinum seems to be more or less the only thing supported,
> I can guess that's why I don't see anything.
> 
> Is that why? :)

No. There is a hardware independent video driver which uses
the framebuffer device. Does singlestepping (Meta-S) work? 
Also, remeber to specify 'processor: 4' in the molrc file.

Btw. I've uploaded a new release of Mac-on-Linux (with
binaries) which works properly on G3 machines. It is possible 
that the G3 fix also solves the 603 problem.

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470   
----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
