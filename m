Message-ID: <3F4275FB.7090808@kegel.com>
Date: Tue, 19 Aug 2003 12:09:47 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: emanuel stiebler <emu@ecubics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK 2.1.0, kernel 2.4.21, MPC8245, ntpd
References: <3F426F17.3090206@ecubics.com>
In-Reply-To: <3F426F17.3090206@ecubics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


emanuel stiebler wrote:
> I get a "Segmentation fault (core dumped)" on my system using ntpd.
> I checked the archives, and there is one messeage about something like
> this on a 405.
>
> Is anybody working on this ? Did I missed some patches ?

No idea, but if you're using ELDK binaries, you might check
with their mailing list.

And then there's always compiling ntpd yourself and running
it under gdb or gdbserver to see where it's crashing...
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
