Date: Tue, 24 Aug 1999 10:56:07 +0200
To: rshaw@inficad.com, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: BootX enhancement request
Message-Id: <19990824105607.023574@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 23, 1999, Robert Shaw <robert.shaw@motorola.com> wrote:

>Ok, that's reasonable. Any thoughts Ben?

I could add a front-end to the various video=xxxx options, and eventually
I can try to find out which option to give the kernel based on queries to
the video driver, but this is not trivial. I'll look into this as soon as
I find some time to play with BootX.



-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
