Date: Tue, 25 May 1999 17:13:54 -0400 (EDT)
From: "Jason Y. Sproul" <jsproul@mail.wesleyan.edu>
Reply-To: jsproul@mail.wesleyan.edu
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb update
In-Reply-To: <Pine.GSO.4.05.9905251650320.14882-100000@mail.wesleyan.edu>
Message-ID: <Pine.GSO.4.05.9905251706510.14882-100000@mail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 25 May 1999, Jason Y. Sproul wrote:

> Now that the dual-bank stuff is in, my boot logo and colours in X are
> rather munged [...] I changed the colour mode returned to the fb
> subsystem when using CMODE_32 from DIRECTCOLOR to TRUECOLOR?

Okay, just shoot me for that one. Doh! (Note to self: Don't "fix" things
you don't fully understand.)

I'm still having intermittent problems with jerky scrolling on the console,
though. Not sure what's going on there... it seems it may happen only after
running X once. Is there some magic in the hardware panning? I have no clue
how this works just yet.

........................................................................
Jason Y. Sproul                    http://www.con.wesleyan.edu/~jsproul/
jsproul@wesleyan.edu            jsproul@iced.com    http://www.iced.com/
     Eagles may soar, but weasels don't get sucked into jet engines.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
