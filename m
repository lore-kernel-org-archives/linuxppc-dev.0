Date: Wed, 07 Jan 2004 13:03:16 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Re: PATCH: Another mpc8xx watchdog driver !!
In-reply-to: <20040106233539.63641C12DD@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3FFB4CC4.5000606@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <20040106233539.63641C12DD@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message <3FFB450D.7060405@tait.co.nz> you wrote:
>
>>>Do you really mean RTC here???
>>
>>Yes - the 866 and derivatives (859 etc) do NOT have a Real Time Clock
>>block. This means that hooking the RTC interrupt to 'kick the dog' is
>>rather difficult :-))
>
>
> That may be the case. But the watchdog code does not use any  RTC  at
> all.
>
>
>>"It is based on the code of Florian Schirmer but using kernel timers (as
>>used by the DENX driver) rather than the RTC."
>
>
> Have you ever seen a MPC8xx watchdog driver that used RTC for
> triggering?

Gosh - egg on face. Got mixed up with the PIT which usually uses a 32KHz
crystal as does the RTC on the mpc860. Well, we don't have a crystal on
the PIT so that (as well as the non-existant RTC) is not available!!

This is what comes from trying to rely on memory alone with 1358 pages
of mpc866 manual :-))

--
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
