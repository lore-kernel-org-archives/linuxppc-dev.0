Date: Sat, 26 Apr 2003 00:55:04 +0200
Subject: Re: ibook2r2 & strange freeze.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: remco@rvt.com
From: Brice Figureau <brice@tincell.com>
In-Reply-To: <200304251312.37645.remco@rvt.com>
Message-Id: <F41AEEC6-7770-11D7-BD12-0003939D5F18@tincell.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, April 25, 2003, at 10:12 PM, Remco Treffkorn wrote:
> On Friday 25 April 2003 08:27, Brice Figureau wrote:
> ...
>> I then commented-out this part of rc.sysinit and then I could boot up
>> to
>> the login prompt.
>
> Seems to me you have more than one problem. I have trouble with
> CONFIG_RTC
> set. Hwclock will hang in rc.sysinit. Try configuring without RTC.
No, CONFIG_RTC is disabled. The crash usually occurs usually before
hwclock.

Anyway, thanks for the idea.

Brice


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
