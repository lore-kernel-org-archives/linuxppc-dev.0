Date: Mon, 30 Aug 1999 17:52:45 +0200
Message-Id: <199908301552.RAA23128@lxp03.cern.ch>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
To: schmitz@opal.biophys.uni-duesseldorf.de
Cc: "David D. Kilzer" <ddkilzer@computer.org>, linux-mac68k@mac.linux-m68k.org,
        linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
Subject: Re: mac-2.3.14.diff: adb
In-Reply-To: <37CAA6F5.D93A168B@biophys.uni-duesseldorf.de>
References: <v03130327b3ebecbebbd3@[192.168.1.1]>
	<199908270917.LAA04250@lxp03.cern.ch>
	<v03130308b3ec440550d3@[192.168.1.1]>
	<199908271414.QAA24261@lxp03.cern.ch>
	<37CAA6F5.D93A168B@biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Michael" == Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> writes:

Michael> Jes Sorensen wrote:
>> No drivers/adb to handle the ADB bus, the char driver should go in
>> drivers/char.
>> 
>> I always disliked drivers/macintosh and drivers/sbus/char for that
>> matter as it seems to me like it was just an easy way to get things
>> past Linus.

Michael> I agree - IIRC Paul created drivers/macintosh as a quick fix to
Michael> get the Mac drivers integrated. I've suggested to move things
Michael> to other places, but Alan sait this would be 'a 2.3 thing' at
Michael> that time. Seems a bit late for that now.

IMHO there is still time, I doubt Linus would object to patch for this
at the moment.

Wouldn't it be natural to move the Mac 8530 serial driver to
drivers/char and the rest to drivers/adb? or is the via stuff not adb
related?

Paul what do you think?

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
