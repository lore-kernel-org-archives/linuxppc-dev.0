From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>, harry eaton <bumpelo@home.com>
Subject: Re: No video or console with 2.4.10 on Tanzania
Date: Mon, 31 Dec 2001 00:04:23 +0100
Message-Id: <20011230230423.20339@smtp.noos.fr>
In-Reply-To: <000901c19168$de54a4c0$6400a8c0@hwrd1.md.home.com>
References: <000901c19168$de54a4c0$6400a8c0@hwrd1.md.home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> I'm trying to upgrade to a 2.4.x based kernel, but it's not working.
>> Everything appears to stop after "arch: exit" is displayed, but
>> in fact the whole booting process continues fine, except nothing
>> is ever sent again to the screen. The log file reveals:
>> ...
>> Fixups for bus 01
>> Unknown bridge resource 0: assuming transparent
>> ...
>> PCI:00:11.0:Resource 0: 81000000-81ffffff (f=3D200)
>> PCI:Cannot allocate resource region 0 of device 00:11.0
>> ...
>> PCI: Failed to allocate resource 0 (8000-7ffffff) for 00:11.0
>>
>> plus other similar message about devices 00:10.0 and 00:0e.0
>>
>> I've tried Benh's latest from ppckernel.org, also the bitkeeper 2.4 =
>> stable,
>> plus a few others, even rolling my own minimal kernel from the 2.4.10
>> source tree in the latest YDL distribution. They all do the same thing.
>>
>> This is on my Starmax 4160 (Tanzania) system. I use the built-in video
>> (ATI 264 vt) and it all works great with 2.2 kernels.

Please, send me the complete boot log under both 2.2 and 2.4, and the
result of lspci -vv (run as root) on both kernels.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
