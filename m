From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199908301627.SAA10148@amber.biophys.uni-duesseldorf.de>
Subject: Re: mac-2.3.14.diff: adb
In-Reply-To: <199908301552.RAA23128@lxp03.cern.ch> from Jes Sorensen at "Aug 30, 1999 05:52:45 pm"
To: Jes.Sorensen@cern.ch (Jes Sorensen)
Date: Mon, 30 Aug 1999 18:27:43 +0200 (CEST)
Cc: ddkilzer@computer.org, linux-mac68k@mac.linux-m68k.org,
        linuxppc-dev@lists.linuxppc.org, paulus@cs.anu.edu.au
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Michael> I agree - IIRC Paul created drivers/macintosh as a quick fix to
> Michael> get the Mac drivers integrated. I've suggested to move things
> Michael> to other places, but Alan sait this would be 'a 2.3 thing' at
> Michael> that time. Seems a bit late for that now.
> 
> IMHO there is still time, I doubt Linus would object to patch for this
> at the moment.
> 
> Wouldn't it be natural to move the Mac 8530 serial driver to
> drivers/char and the rest to drivers/adb? or is the via stuff not adb
> related?

The general VIA stuff isn't ADB related via-cuda and via-pmu are the low
level ADB drivers though.

	Michael

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
