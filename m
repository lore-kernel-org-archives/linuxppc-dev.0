To: "rick.liu" <dovi@eyou.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Why my console output nothing 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "14 May 2003 15:27:00 +0800."
             <20030514152700.68497.qmail@eyou.com>
Date: Wed, 14 May 2003 10:10:37 +0200
Message-Id: <20030514081042.2C117C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <20030514152700.68497.qmail@eyou.com> you wrote:
>
> you mean it's not the problem of my console configuration but the u-boot
> program?

That might be the case. But obviously I can only speculate.

> But I thought it might at least output some message of the board before it can
> output the prompt "=>",is that right? Listing all my chang in the TQM860L.h

This is correct. But you need to get a couple of things right  before
you see a single character onthe console.

> and in tqm8xx.c,I did like this:

You should not change existing files in an incompatible way.  Instead
you  should  add  your  own set of files for your hardware. Otherwise
there will not be any chance to include your modifications  intot  he
public source tree.

> 1.changed upm_table according to my sdram;
> 2.modify the register's value in the function initdram()

I have no way to tell if your modifications might work. But  this  is
not  (yet)  relevant.  You will see output on the console long before
RAM is accessed.

> :-),I am trying to learn,would u  recommend some helpful material about
> u-boot?

Read the sources :-)

> >Finally: did you order your BDI2000 yet? You will  probably  need  it
> >soon.
>
> I know that,and I will try to persuade my "boss".

Tell him that you are stuck and cannot continue without the right tool.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All a hacker needs is a tight PUSHJ, a loose pair of UUOs, and a warm
place to shift.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
