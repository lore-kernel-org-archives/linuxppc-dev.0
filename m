Message-ID: <39A5E3F7.1030409@in.tum.de>
Date: Fri, 25 Aug 2000 03:11:51 +0000
From: sprenger <sprenger@in.tum.de>
MIME-Version: 1.0
To: schmitz@opal.biophys.uni-duesseldorf.de
CC: linuxppc-dev@lists.linuxppc.org
Subject: RE: xf4 and lombard
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


my x-server is working now after using yaboot - thanks !

using a 2.2.17pre15 worked fine, but with a 2.4-test6 kernel the
x-server crashed often especially under heavy load - like compiling
mozilla-m17 !? but even on the console the build would stop three times
with error 132, just had to restart the build - strange .
i just upgraded to 2.4-test7, and the x-server seems to be stable now
(compiling a new mozilla while using the old one - really a heavy load
...). but now i have some garbage (several blue dots) on my screen,
especially on the "gkrellm"-window.
any idea ?

i will try a new rsynced version of the ati-driver during the weekend.

by the way, do you know the standard key-combination to emulate the
second and third mouse button ? with the 2.4-test6 they used to be
"fn-ctrl" and "fn-alt". but when i upgraded to 2.4-test7 i could not
find them anymore.

hope you can help me out again.
/thorsten


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
