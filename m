From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
Date: Sun, 13 May 2001 13:41:00 +0200
Message-Id: <20010513114100.11388@smtp.wanadoo.fr>
In-Reply-To: <3AFE70AD.82BA5ED4@folkwang-hochschule.de>
References: <3AFE70AD.82BA5ED4@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>ay 14 13:15:01 ephraim pmud[271]: initiating user requested sleep
>
>how can i request sleep ? is there some hotkey that i might be
>triggering ? but then, it seems to happen no matter what i type.
>
>May 14 13:15:01 ephraim pmud[271]: running /etc/power/pwrctl sleep
>battery
>May 14 13:15:01 ephraim pwrctl: no function for PMU 12
>May 14 13:15:01 ephraim pmud[271]: going to sleep

Looks like it's pmud who is triggering the sleep request. Looks like
it thinkgs it got a sleep request from either the "snooze" program,
Batmon sleep button or whatever...

I don't know pmud very well, but I'd rather start from it and add
some debug output to it to see what's going on.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
