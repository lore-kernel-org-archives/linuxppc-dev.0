From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B236A5@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Need openssh for embedded linux on 440GP
Date: Thu, 6 Mar 2003 08:02:55 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is more of an ELDK question that a general embedded linux question.

I am trying to get openssh installed and running on my embedded 440
platform. 'openssh' is not part of the target packages provided with the
ELDK, so I figure there's 2 ways to do it:

(a) cross-compile on my host
(b) compile it on my target system

I haven't tried (a) yet, as openssh does not seem to be very cross-compile
friendly and I'm still getting comfortable with the whole 'cross-compiling'
from source using ELDK.

I went ahead and proceeded with (b). I retrieved the latest source from
www.openssh.com, unpacked and built it on my target system (filesytem nfs
mounted). It took a while, but everything built ok. I thought I was home
free until I tried to either:

  (i)  start the sshd daemon
       The daemon starts OK. However, when I ssh to the
       Target, it barfs on a 'CRC' error.
  (ii) ssh to another machine from the target
       When I try to connect, I get an error message related
       Errors at the MAC addr level.

Can't provide more detail at this point on the specific errors as I'm
rebuilding ssh as I write this (on the target) and can't get the info.

Is the direction I'm going in the logical direction? I've worked on embedded
systems for years, but this is the first with embedded linux, and the first
time I've actually built something on my target!! It feels unusual, but I
don't see why it shouldn't work, and seems like a better choice than
cross-compiling.

Feed me back please.

Also, is there any particular reason ssh is not included in the ELDK target
packages?

Thanks

-- Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
