From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: =?ISO-8859-1?Q?Michel=20D=E4nzer?= <michdaen@iiic.ethz.ch>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: xfree86/fbdevhw not sending right mode to radeonfb.c
Date: Sat, 24 Nov 2001 19:04:16 +0100
Message-Id: <20011124180416.25049@smtp.wanadoo.fr>
In-Reply-To: <1006623522.24435.63.camel@pismo>
References: <1006623522.24435.63.camel@pismo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> That is only part of the problem, the other is that if you change the
>> depth from what is used by the frame buffer it does mess up as others have
>> reported.
>
>I believe Ben's work on radeonfb should fix this.
>
>We were talking about different resolutions, which probably breaks due
>to the fbdev driver.

Well, radeonfb has a nasty bug in switch() that could make it lose
track of what console is current if you change only the depth. I
fixed that along with a few other things, it should be in my rsync
tree now (you might need some time for mirrors to be up to date
on rsync.penguinppc.org). It also does 5:5:5 now (for MOL).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
