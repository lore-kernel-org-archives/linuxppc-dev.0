Message-ID: <37CAA6F5.D93A168B@biophys.uni-duesseldorf.de>
Date: Mon, 30 Aug 1999 17:44:53 +0200
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Reply-To: schmitz@opal.biophys.uni-duesseldorf.de
MIME-Version: 1.0
To: Jes Sorensen <Jes.Sorensen@cern.ch>
CC: "David D. Kilzer" <ddkilzer@computer.org>, linux-mac68k@mac.linux-m68k.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: mac-2.3.14.diff: adb
References: <v03130327b3ebecbebbd3@[192.168.1.1]>
		<199908270917.LAA04250@lxp03.cern.ch>
		<v03130308b3ec440550d3@[192.168.1.1]> <199908271414.QAA24261@lxp03.cern.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jes Sorensen wrote:
> No drivers/adb to handle the ADB bus, the char driver should go in
> drivers/char.
> 
> I always disliked drivers/macintosh and drivers/sbus/char for that
> matter as it seems to me like it was just an easy way to get things past
> Linus.

I agree - IIRC Paul created drivers/macintosh as a quick fix to get the
Mac drivers integrated. I've suggested to move things to other places,
but Alan sait this would be 
'a 2.3 thing' at that time. Seems a bit late for that now.

	Michael

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
