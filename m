Message-ID: <3F427B58.3000409@ecubics.com>
Date: Tue, 19 Aug 2003 13:32:40 -0600
From: emanuel stiebler <emu@ecubics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK 2.1.0, kernel 2.4.21, MPC8245, ntpd
References: <3F426F17.3090206@ecubics.com> <3F4274D1.4050909@mvista.com>
In-Reply-To: <3F4274D1.4050909@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle wrote:

> emanuel stiebler wrote:
>
>>
>> Hi all,
>> I get a "Segmentation fault (core dumped)" on my system using ntpd.
>> I checked the archives, and there is one messeage about something like
>> this on a 405.
>>
>> Is anybody working on this ? Did I missed some patches ?
>
>
> If you clock is sufficiently out of date..  (I.e. 50/60 more? years
> wrong) then you can get into an overflow situation.  While I've never
> seen it segv, I have seen it do other 'interesting' things.
>
> Try setting your clock to Jan 1 2000, then run ntpd and see what happens.

I checked that already ;-)
I set the clock manually before that, and the difference between the
server and the local clock was less than a minute.

Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
