From: "Chris Backas" <cbackas@rcn.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "Robert Thompson" <rothomp3@vt.edu>
Date: Fri, 14 Jul 2000 19:04:09 -0400 (EDT)
Reply-To: "Chris Backas" <cbackas@bigfoot.com>
In-Reply-To: <016d01bfedec$18c9b400$1a6a1504@strayer.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: iBook woes: Update
Message-Id: <E13DF6t-0005hH-00@smtp01.mrf.mail.rcn.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 14 Jul 2000 19:34:27 -0400, Robert Thompson wrote:

>>
>> Wait! Does your trackpad work? If so, then excuse me...
>WAAAAAAAAHHHHHHHHH!
>> Why doesn't mine work? What are you doing differently? Could it be the new
>> yaboot? Let me try it and see...
>>
>Nope, it isn't the new yaboot. Now I'm *really* confused... my trackpad
>still doesn't work. I can (almost) guarantee that I'm not an idiot, but it's
>beginning to look like I must be doing something wrong.

Yeah, it works fine, and always did.  I dunno, when I went from the 2.2.15 kernels to the 2.2.17 I followed the instructions on BenH's page for the new input stuff.  I did notice
that the DOTConfig file provided with 2.2.17pre10-ben1 didn't enable the new input by default, but I turned that on when I compiled it.

I think the webpage also forgot to rm /dev/adbmouse; ln -s /dev/input/mice /dev/adbmouse

But, I may have just skipped that line by accident, and I did it later anyway.

Chris Backas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
