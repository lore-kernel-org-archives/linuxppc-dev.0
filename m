Message-Id: <199904210150.VAA22908@mail-2.global2000.net>
Date: Tue, 20 Apr 1999 21:41:25 -0400
Subject: FW: Darwin Streaming Server on Linux ix86
From: "AArthur" <aarthur@h30.net>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just more info on compiling qt/darwin streaming server for you guys to take
a look at if you not subscribed to the darwin-developer list.

----------
From: Pedro Ivo Andrade Tavares <p-tavares@usa.net>
To: B <bolen@hcs.harvard.edu>
Subject: Re: Darwin Streaming Server on Linux ix86
Date: Tue, Apr 20, 1999, 8:45 PM


Some notes on compiling QTFileLib on Linux (Debian 2.2[potato], Pentium):

First thing I noticed: The -ansi flag must be removed from the Makefile in
Linux systems,
or certain prototyped won't be defined (e.g. strdup). Also, the line

#include <getopt.h>

should be included in OSHeaders.h

Other than that, it's just compiling with -D__FreeBSD__ . I'm testing
building libQTFileLib
as a shared library. I'm sure it will be useful to someone this way.

At 20:14 19/04/99 -0400, you wrote:
>On Mon, 19 Apr 1999, Pedro Ivo Andrade Tavares wrote:
>
>> I'm thinking of changing the current way of having defines for each OS into
>> an autoconf - generated header. Unfortunately, I know nothing about how to
>> use autoconf.
>
>Ditto, I think it might be time to learn...

maybe we can think of something together...  The current #define's  system
is OK
for now, but when you add some more OS's, it's going to get unwieldly...

>> As to the Server, I think it's best to build new makefiles. I think I'm
>> gonna use the GNUstep-make package, it seem suited to converstion of PB
>> projects.
>
>Yeah, I was looking at them, and I was thinking of just doing a conversion
>by hand to a plain makefile format.  If the GNUStep stuff can save some
>time, then by all means...

Well, I tried yesterday, and just discovered gstep-make doesn't recognize
*.cpp files.
As I lack the expertise to add then, it's either (a) bug the developers to
add it or (b) wing
it with a new Makefile.

>What about system dependant stuff?  There are the whole OS*.cpp set of
>files, anybody start looking at those?

Hm... The OSHeaders in QTFileLib was simple enough... Haven't looked at the
Server yet in this matter...
However, it uses Mach cthreads! Anyone know how to convert this code to
pthreads? I'm stumped on that...

>> Anybody else interested?
>me me!  I don't have a lot of background, but I am currently writing
>'nachos' for my OS class...  (anybody else learned on nachos?)

NachOS? Nice pun in an OS name... Never heard of it, though. Any good?

So, anybody else working on it, or are just the two of us? Let's get
together, folks!

Pedro Ivo Tavares


====================================================================
Unsubscribe: <darwin-development-unsubscribe@public.lists.apple.com>

Help: <http://www.lists.apple.com/darwin-development.html>
or    <darwin-development-info@public.lists.apple.com>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
