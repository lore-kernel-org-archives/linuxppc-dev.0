Date: Fri, 27 Aug 1999 16:14:11 +0200
Message-Id: <199908271414.QAA24261@lxp03.cern.ch>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
To: "David D. Kilzer" <ddkilzer@computer.org>
Cc: linux-mac68k@mac.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: mac-2.3.14.diff: adb
In-Reply-To: <v03130308b3ec440550d3@[192.168.1.1]>
References: <v03130327b3ebecbebbd3@[192.168.1.1]>
	<199908270917.LAA04250@lxp03.cern.ch>
	<v03130308b3ec440550d3@[192.168.1.1]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "David" == David D Kilzer <ddkilzer@computer.org> writes:

David> Jes Sorensen <Jes.Sorensen@cern.ch> wrote:

>> Do not belong here, create a drivers/adb if you need it - stop
>> putting things in drivers/macintosh.

David> Well, drivers/macintosh is PPC ADB code.  If drivers/macintosh
David> shouldn't exist, then shouldn't it be changed or moved at a
David> higher level?

IMHO yes, ADB code will be useful to the NeXT people if they ever get
the port going.

David> In reality, there is some ADB mouse code in drivers/char, too, so
David> I wonder if drivers/char/adb would make more/less sense than
David> drivers/adb?

No drivers/adb to handle the ADB bus, the char driver should go in
drivers/char.

I always disliked drivers/macintosh and drivers/sbus/char for that
matter as it seems to me like it was just an easy way to get things past
Linus.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
