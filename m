Date: Tue, 24 Aug 1999 10:43:55 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
In-Reply-To: <19990824110229.025988@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.990824104012.26367B-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Aug 1999, Benjamin Herrenschmidt wrote:

> MacOS no longer relies on the nvram setting. Video drivers are free to

That's not _entirely_ true.  The hardware itself relies on the nvram
setting in order to determine the initial startup mode before it starts
loading MacOS.  That's why you can do tricks with newer versions of MacOS
like have the preferences set to 1024x768 and the pram/nvram set to
640x480 and have it switch half-way into booting. (Makes it nice for
MkLinux on x100's where you have to be in 8-bit color, but don't want to
run MacOS that way.)  The Monitors & Sound CP does set the nvram value, at
least on some machines, unless it changed quite recently, but you
sometimes have to delete its prefs files to convince it to do so.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
