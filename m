Message-ID: <3F4274D1.4050909@mvista.com>
Date: Tue, 19 Aug 2003 14:04:49 -0500
From: Mark Hatle <fray@mvista.com>
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
>
> Hi all,
> I get a "Segmentation fault (core dumped)" on my system using ntpd.
> I checked the archives, and there is one messeage about something like
> this on a 405.
>
> Is anybody working on this ? Did I missed some patches ?

If you clock is sufficiently out of date..  (I.e. 50/60 more? years
wrong) then you can get into an overflow situation.  While I've never
seen it segv, I have seen it do other 'interesting' things.

Try setting your clock to Jan 1 2000, then run ntpd and see what happens.

--Mark

> cheers & thanks
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
