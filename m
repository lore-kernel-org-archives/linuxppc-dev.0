From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
Date: Sat, 12 May 2001 22:34:22 +0200
Message-Id: <20010512203422.23549@smtp.wanadoo.fr>
In-Reply-To: <3AFD9868.29C558@folkwang-hochschule.de>
References: <3AFD9868.29C558@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>* the box usually falls asleep again after waking up. when woken
>again, it stays up like it should.

Never seen that. How do you trigger sleep ?

>* every 10 or so sleep cycles, the machine locks up. blank screen,
>no standby-led, and i can only power off with ctrl-alt-apple-power.
>sysrq fails, too.

It locks up on wakeup or on sleep ?

>* the box falls asleep sometimes even when i'm busy typing or moving
>the mouse. this happens at least once every half hour.

What do you mean by "fall asleep" ? it stops working ? how do you
get it back ?

>some minor glitches that might be unrelated to power management:
>* the first console cannot issue ctrl commands like break or
>suspend, while the others still do. resetting doesn't help.
>* there seems to be a problem under KDE with keyboard/trackpad
>focus: sometimes they are attached to different windows.
>
>i'd like to help tracking this down, but i'm rather new to the ppc
>platform, so please tell me what to do.
>is there a place where i can monitor power management events ? (more
>detailed than in the syslog)
>
>regards,


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
