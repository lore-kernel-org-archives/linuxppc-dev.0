From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	"Kevin B.  Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>, <ajoshi@unixbox.com>
Subject: Re: radeonfb.c flakiness
Date: Tue, 19 Feb 2002 01:04:05 +0100
Message-Id: <19300421142039.19078@smtp.wanadoo.fr>
In-Reply-To: <20020218205555.OVAC2625.tomts5-srv.bellnexxia.net@there>
References: <20020218205555.OVAC2625.tomts5-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Tried that no help.  I have now figured out that the only way to make the
>DFP startup properly is to zap the parameter ram (one chime's worth) and
>then it will actually startup.  If I don't do that and I have been running
>MacOSX then no matter what I do or try it does right after the yaboot
>prompt I see a flash and then everything stays blank.

that's strange, since a friend of mine is experiencing exactly the same
issue with a Rage M6 (radeon mobility) in a titanium powerbook, while I
never see it here. The only difference is that his has a little bit slower
CPU.

>Perhaps Mac OSX driver is writing something to nvram or is moving the
>memory mapping for the card's interfaces.  Either way without that single
>pram zap, the screen simply goes dead and stays dead.

I think it doesn't write anything but mode & backlight infos. Make sure
your problem isn't caused by the powerbook backlight code ;) I think the
way we currently fetch the backlight setting from pram is kinda broken.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
