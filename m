To: =?euc-kr?q?JACK=20HWAN?= <jhfami@yahoo.co.kr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting time 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Feb 2004 10:39:45 +0900."
             <20040209013945.68409.qmail@web21506.mail.yahoo.com>
Date: Mon, 09 Feb 2004 14:44:42 +0100
Message-Id: <20040209134447.7F1E2C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <20040209013945.68409.qmail@web21506.mail.yahoo.com> you wrote:
>
>  I ported linux-2.4.x to my motorola ppc8xx custom
> board. And it works quite
> well.
> But the problem is booting time. It cosume too much
> time than other embedded
> OSes.
> I disabled all options that I can. But it still slow.
>  I took about 15~16 sec. the others are only takes
> about 8 sec.
>  How can I reduce the booting time?

Please provide a bit more  information  about  your  hardware  (which
processor  -  a  MPC850  with  it's tiny caches will be slower than a
MPC860P with the bigger ones; which CPU and  bus  clock  frequencies;
which memory bus width - 32 bit?).

Then define how you measure "boot time" - where  does  it  begin  (at
power  on?  when  your  boot  loader  starts loading the kernel? when
control is passed to the uncompressed Linux kernel?) and  where  does
it  end  (when  the  init  process  gets started? when the first user
application starts running?  when  you  entered  run  level  3  in  a
classical SysV init style system?).

For a "standard" system with 50 MHz CPU and 50 MHz bus  clock  I  can
demonstrate  that  it takes not more than 3...4 seconds from power on
until the first application process is running.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is dangerous to be right on a subject  on  which  the  established
authorities are wrong.                                    -- Voltaire

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
