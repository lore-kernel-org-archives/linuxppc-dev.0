Date: Wed, 25 Aug 1999 22:29:35 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: David Riley <happyoscar42@usa.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
Message-ID: <19990825222935.A20023@them.org>
References: <37C35F10.6159B81C@usa.net> <Pine.A41.3.96LJ1.1b7.990825194557.72736C-100000@unlserve.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.A41.3.96LJ1.1b7.990825194557.72736C-100000@unlserve.unl.edu>; from Takashi Oe on Wed, Aug 25, 1999 at 07:49:34PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 25, 1999 at 07:49:34PM -0500, Takashi Oe wrote:
> 
> On Tue, 24 Aug 1999, David Riley wrote:
> 
> > Some of the drivers don't do video=xxxx.  I know controlfb doesn't.  Is there
> > a _good_ reason for this, or does controlfb just not like me?
> 
> It's probably a simple oversight.  Last I checked,
> controlfb does have the necessary code for "video=...", while
> drivers/video/fbmem.c lacks an entry for controlfb to actually activate
> the code.

Translation - I'm being far too lazy.  I have some other work for the
controlfb underway, and I'm hoping to make some progress.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
