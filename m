Date: Wed, 25 Aug 1999 19:49:34 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: David Riley <happyoscar42@usa.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
In-Reply-To: <37C35F10.6159B81C@usa.net>
Message-ID: <Pine.A41.3.96LJ1.1b7.990825194557.72736C-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Aug 1999, David Riley wrote:

> Some of the drivers don't do video=xxxx.  I know controlfb doesn't.  Is there
> a _good_ reason for this, or does controlfb just not like me?

It's probably a simple oversight.  Last I checked,
controlfb does have the necessary code for "video=...", while
drivers/video/fbmem.c lacks an entry for controlfb to actually activate
the code.

Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
