Message-ID: <37C35F10.6159B81C@usa.net>
Date: Tue, 24 Aug 1999 23:12:17 -0400
From: David Riley <happyoscar42@usa.net>
Reply-To: happyoscar42@usa.net
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
References: <19990824105607.023574@mail.mipsys.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> On Mon, Aug 23, 1999, Robert Shaw <robert.shaw@motorola.com> wrote:
>
> >Ok, that's reasonable. Any thoughts Ben?
>
> I could add a front-end to the various video=xxxx options, and eventually
> I can try to find out which option to give the kernel based on queries to
> the video driver, but this is not trivial. I'll look into this as soon as
> I find some time to play with BootX.

Some of the drivers don't do video=xxxx.  I know controlfb doesn't.  Is there
a _good_ reason for this, or does controlfb just not like me?


--
--"Your mouse has been moved.  Windows 95 must be restarted for change to take
effect."


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
