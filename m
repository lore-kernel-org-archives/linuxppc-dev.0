From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
Date: Sun, 13 May 2001 12:06:49 +0200
Message-Id: <20010513100649.25517@smtp.wanadoo.fr>
In-Reply-To: <3AFE3C09.835966B5@folkwang-hochschule.de>
References: <3AFE3C09.835966B5@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>well, it looks like it's going to sleep, but the standby led doesn't
>blink. just like when i switch it off, except i can't switch it on
>again by simply pressing "power", so i suspect it hangs.

Ok, well, it dies. Are you in console or X mode when that happens ?
>
>> >* the box falls asleep sometimes even when i'm busy typing or moving
>> >the mouse. this happens at least once every half hour.
>>
>> What do you mean by "fall asleep" ? it stops working ? how do you
>> get it back ?

>it enters sleep mode, even though there are pretty many keyboard and
>mouse events that should keep it from doing so.
>i get it back by pressing a key after waiting a few seconds.
>(immediately after entering sleep mode, key events seem to be
>ignored for a few seconds.)

Are you sure it's actually sleep mode (with the blinking sleep LED) ?
and not the console blank mode or X blank mode ?

That's really weird.... maybe pmud incorrectly thinks you are running
off an empty battery ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
