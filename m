To: deepesh@india.tejasnetworks.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EP8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Jul 2003 19:32:34 +0700."
             <1058882554.3f1d43faafee2@pop-mail.india.tejasnetworks.com>
Date: Tue, 22 Jul 2003 17:52:23 +0200
Message-Id: <20030722155228.DF415C6D82@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <1058882554.3f1d43faafee2@pop-mail.india.tejasnetworks.com> you wrote:
>
>   I loaded my EP8260 board with UBOOT. This was working fine. Then I loaded a

First I would like to point out (like many times before) that  U-Boot
related  questions  are  off-topic  on  a  linuxppc-dev mailing list.
Please post such questions to the u-boot-users list.

> binary into RAM using tftp. Then tried copying the stuff to flash. When I could
> not copy things into flash directly, I erased a few sectors randomly and then
> copied the binary to flash. Then when I reset the board, it did not come up.

One of my teachers used to say that some people only  learn  when  it
hurts really bad.

I hope you understand that you should have  investigates  _why_  yuou
could  not  copy your image to flash. Thi is supposed to work, and if
it fails it usually means that you made  something  wrong.  Analyzing
the  error  and  understanding _what_ you did wrong is very important
for you to avoid the same error in the future.

Well, and "erasing a few sectors randomly" is such a bad idea that  I
better keep my mouth shut.


> I put back the u-boot into the flash using BDI2000. But now I am getting weird
> characters on the screen. I have looked at the minicom settings-- It is 115200
> and 8N1. These were the settings with which I was working before also. What I am
> not able to understand is the reason for the weird characters.

Probably you overwrote more than you think.

Restart from scratch: erase the _whole_  flash  memory,  and  install
_only_ U-Boot. Then power-cycle the board. Then check again.


And never ever erase "random sectors" again.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"When anyone says `theoretically,' they really mean `not really.'"
- David Parnas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
