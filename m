From: Josh Huber <huberj@WPI.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14193.7450.750844.387018@cpu.WPI.EDU>
Date: Wed, 23 Jun 1999 13:44:58 -0400 (EDT)
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerBook sleep, first try
In-Reply-To: <19990623104345.023685@mail.mipsys.com>
References: <19990614114347.006593>
	<19990623104345.023685@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Still looking at the code, but I just thought I'd mention that I can't seem to get a kernel (Paul's 2.2.10) patched with your patches to boot using atyfb.  Right after the initial boot screen (before the linux console gets initialized, after bootx) the screen 'melts' away. This is the best description I have.

Looking at the changes to atyfb I can't see what could be causing this.  Perhaps someone who knows atyfb a little better could take a look?

Josh

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
