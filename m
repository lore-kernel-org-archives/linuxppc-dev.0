Message-ID: <3FFB4EA8.20809@embeddededge.com>
Date: Tue, 06 Jan 2004 19:11:20 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Robin Gilks <robin.gilks@tait.co.nz>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PATCH: Another mpc8xx watchdog driver !!
References: <20040106233539.63641C12DD@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In message <3FFB450D.7060405@tait.co.nz> you wrote:
>
>>>Do you really mean RTC here???
>>
>>Yes - the 866 and derivatives (859 etc) do NOT have a Real Time Clock
>>block. This means that hooking the RTC interrupt to 'kick the dog' is
>>rather difficult :-))


Why would you want to do that?  Not a very effective watchdog
timer.  Even in the most hopelessly crashed system the RTC or other
timer interrupts usually continue to operate.  An effective watchdog
needs to be managed throughout the whole boot process and handed off
along the way to some application, such that any system error will
cause the application to fail to kick the timer.

Good luck :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
