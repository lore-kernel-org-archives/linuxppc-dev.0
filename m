From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Grimm <joker@cymes.de>,
	LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Design weakness in /proc/pmu ?!
Date: Thu, 18 Apr 2002 20:31:47 +0200
Message-Id: <20020418183148.25976@smtp.wanadoo.fr>
In-Reply-To: <3CBF14C1.6080802@cymes.de>
References: <3CBF14C1.6080802@cymes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>As you could see battery 0 is fully charged but the time remaining value
>is calculated as zero. If you now calculate the overall time remaining
>simply as sum of the time rem. of each battery you will get a wrong time
>and possibly bother the user with unnessecary warnings.
>
>I suggest to move the time rem. value out of the /proc/battery_* files
>into the /proc/info file and store an overall time-remaining value
>there. Because the time until power off is a quality of the whole system
>mainly defined through the overall power consumption. It isn't a feature
>of a single battery.
>
>What do you think?

It's difficult to find a suitable answer. The time remaining is
obtained directly from the PMU  on newer machines, we don't really
have the proper algorithm to calculate it on these, what
machine did you get those dumps from ? We may simply have a bug
on older machine calculation causing that 0, in which case it
has to be fixed.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
