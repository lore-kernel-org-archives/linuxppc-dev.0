In-Reply-To: <v02140b00b2a6453f1cd9@[209.157.72.95]>
Date: Wed, 23 Dec 1998 10:00:26 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: "Timothy A. Seufert" <tas@mindspring.com>, David Ray <daver@idiom.com>,
        Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Test kernels for chipsfb (2400/3400)
Message-Id: <19981223100026.009089@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got a first round of feedback and I uploaded 2 new test kernels:

 <http://calvaweb.calvacom.fr/bh40/vmlinux_test3.gz>
 <http://calvaweb.calvacom.fr/bh40/vmlinux_test4.gz>

(the first one uses truecolor for chipsfb, the second directcolor). offb
is "fixed" to disable the ATI kuldge when not in 8 bits (apparently
breaks some models like PowerBook G3 Series) so "No video driver" should
work all the time again.

Note that those kernel will do funny things with your ADB like
auto-setting handler IDs of mice to 2 or 4 (depending on what the mouse
supports) and detecting the powerbook trackball. All this is quite
verbose (lots of printks) and I would like to know if it breaks
something. The result of those changes should be that now, mice should
use better capabilities by default and mousemode should not be necessary
most of the time.
Note also that the trackpad tapping is partially implemented (you will be
able to click by tapping but sometimes it behaves strangely).

I'll post cleaned up patches for all this later today or later this week.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
