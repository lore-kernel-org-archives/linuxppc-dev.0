From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: daenzerm@student.ethz.ch, Josh Huber <huber@mclinux.com>
Cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Message-Id: <v03110705b5dbf84a56dd@[129.100.29.243]>
In-Reply-To: <39B64777.5E71D9CE@relog.ch>
References: <20000906091501.A2303@mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 6 Sep 2000 09:37:06 -0400
Subject: Re: galeon
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I do nightly mozilla builds once or twice a month and have had no problems
with seg-faults.

I have also build galeon awhile back and it seemed to work (but I did not
test it much).

I think there are pre-compiled version of galeon on the linuxppc inc site
in their contributed archive.

As for mozilla, try the nightly source trees and not M17.  There were two
patches I submitted to fix problems with netscape threads and passing
non-promoted types via va_arg that have recently been included (finally!)
into the mozilla source tree and are now in nightly builds.

Kevin



At 09:32 -0400 9/6/00, Michel Dänzer wrote:
>Josh Huber wrote:
>>
>> Anyone get glaeon to run properly?  I get segfaults when it tries to
>> initialize the mozilla rendering engine.
>>
>> I'm using the mozilla debian package from woody, version M17.
>
>Do you get Mozilla running in the first place? It always segfaults on me.
>
>
>Michel
>
>
>--
>Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
>Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project
>


--
Kevin B. Hendricks, Associate Professor of Operations and Information
Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
