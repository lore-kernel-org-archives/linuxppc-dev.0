From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
Date: Sat, 8 Dec 2001 21:05:41 +0100
Message-Id: <20011208200541.19242@smtp.wanadoo.fr>
In-Reply-To: <3C126A90.C9768C76@folkwang-hochschule.de>
References: <3C126A90.C9768C76@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> >after a few days of frequent use, i can say that sleep/wakeup
>> >bahaviour has improved vastly.
>> >however there was again one hard lockup yesterday.
>> >i was on the road when it hit, so i haven't been able to ping or ssh
>> >into the machine.
>> >i think it only happens when you strike a key immediately after
>> >sleep, before the standby led starts glowing.
>>
>> Ok, I'll do some experiments and see if I can find something.
>
>let me know if can test something for you.
>is there any bulletproof method to capture kernel messages on a
>pismo when it goes bang ?
>has somebody used the modem port as a serial console ? i have a
>spare modem lying around, perhaps it might be worth trying...

xmon_printf (on screen) is usually a working properly if you add
your own messages, but if you are debugging sleep, you may have to
disable display sleep to see the messages.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
