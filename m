Date: Thu, 31 Dec 1998 22:26:02 +0100
To: linuxppc-dev@lists.linuxppc.org, David Ray <daver@idiom.com>
CC: Paul Mackerras <paulus@cs.anu.edu.au>,
        "Timothy A. Seufert" <tas@mindspring.com>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Test kernels for chipsfb (2400/3400)
Message-Id: <19981231222602.021063@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 31, 1998, David Ray <daver@idiom.com> wrote:

>CC: Paul Mackerras <paulus@cs.anu.edu.au>
>----------
>Hi, I wanted to give an update with my pb2400 results with the latest kernels
>from Ben. My access to the computer & email is intermittent during these
weeks
>but I had a chance to check out the builds available on 12.31.1998. I tried
>Ben's experimental build with extra changes to chipsfb.c and ADB
changes, with
>the following results:

Tim released a new driver fixing even more problems. It should be
included in the main tree real soon now and it will be included in any
test kernel I post in the meantime (there is some more adb stuff in the
pipeline including MacX mice support).

>- Despite corrupted colors in X, I was still able to get around in X, see the
>cursor and type into terminal windows, etc. THE NEW TRACKPAD TAPPING CODE IS
>EXCELLENT!!!! Thank you!  To put it simply, this has almost the same trackpad
>behavior as the Trackpad Control Panel in MacOS 8.x. Thanks for providing the
>diff.

It's actually the same behaviour, this is handled by the trackpad itself
;-) My work was simply to give the correct values to the trackpad for
configuration and I used values "spied" from MacOS. There's also command
line tool for changing the config in progress here.

>Before the holiday season I was compiling my own kernels with the latest
>patches for chipsfb.c but I haven't been able to keep up with t he
latest over
>these last few weeks. Hopefully this email is useful in debugging the
problems
>with chipsfb.c. I'll try to update myself next week.

Things are moving quickly with the big merge almost finished, you may
just want to wait for the final 2.2 or a new pre-something, you'll get
the most up-to-date patches for chipsfb.
My ADB patches may or may not be part of 2.2.0, I have separated the
first set with little change to adb.c/.h on one side and a more complete
reorganisation of the adb stuff on other side. This should make the merge
more easy for the first one. I'm still testing things however, I don't
know when it will be fully ready (quite soon hopefully).


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
