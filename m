Date: Tue, 31 Aug 1999 17:21:31 +1000
Message-Id: <199908310721.RAA17352@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: ddkilzer@computer.org
CC: Jes.Sorensen@cern.ch, schmitz@opal.biophys.uni-duesseldorf.de,
        linux-mac68k@mac.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
In-reply-to: <v03130302b3f1013159dd@[192.168.1.1]> (ddkilzer@computer.org)
Subject: Re: mac-2.3.14.diff: adb
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199908301552.RAA23128@lxp03.cern.ch> (message from Jes
 Sorensen	on Mon, 30 Aug 1999 17:52:45 +0200)
 <v03130327b3ebecbebbd3@[192.168.1.1]>
 <199908270917.LAA04250@lxp03.cern.ch>
 <v03130308b3ec440550d3@[192.168.1.1]>
 <199908271414.QAA24261@lxp03.cern.ch>
 <37CAA6F5.D93A168B@biophys.uni-duesseldorf.de>
 <199908301552.RAA23128@lxp03.cern.ch> <v03130302b3f1013159dd@[192.168.1.1]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David D. Kilzer <ddkilzer@computer.org> wrote:

> The issue at hand is that Jes believes drivers/macintosh should not exist

I still haven't heard why.  I personally would like something more
compelling than "Jes doesn't like it" before changing an arrangement
that is working just fine AFAICS.

> I would appreciate it if Jes and Paul would come to an agreement on where
> the code belongs so we can get on with the ADB merger.  :^)

Jes is more of a "theoretician" than I am, I tend to be more
pragmatic, so this could be a problem. :-)  I will accept patches for
drivers/macintosh from the m68k mac folks.  I have some reservations
about the current adb merge patches, though, which I'll mention once
I've had a closer look at the patches.  In general I'm happy with a
drivers/adb directory but I don't think drivers/macintosh should go
away.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
