From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <jason@openinformatics.com>
Cc: Ethan Blanton <eblanton@cs.ohiou.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Shift keycodes on the iBook
Date: Tue, 3 Sep 2002 22:15:27 +0200
Message-Id: <20020903201527.3753@192.168.4.1>
In-Reply-To: <87znuzksx9.fsf@openinformatics.com>
References: <87znuzksx9.fsf@openinformatics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> >Is this a hardware limitation, or just a limitation of the current
>> >maps?  If it is the latter, can it be easily fixed?  I'm willing to
>> >provide whatever information is necessary if the problem is just that
>> >the appropriate developer needs information about the iBook keyboard.
>>
>> AFAIK, it's a HW limitation (or at least a limitation of the PMU's
>> firmware), there is no workaround I know about.
>
>The interesting thing is that was what was believed for years about
>the locking capslock key as well...

The locking capslock is in HW as well, there is a hack to turn capslock
into some different key, but it's really a hack.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
