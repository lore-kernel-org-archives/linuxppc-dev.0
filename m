Message-Id: <v04003a01b611f5a4fcda@[24.70.162.14]>
In-Reply-To: <19340911041012.13299@192.168.1.2>
References: <200010170601.IAA06906@piglet.grunz.lu>
 <200010170601.IAA06906@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 17 Oct 2000 07:34:33 -0500
To: Benjamin Herrenschmidt <bh40@calva.net>, <mlan@cpu.lu>,
        <linuxppc-dev@lists.linuxppc.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: linux-pmac-stable SMP issues
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:38 AM -0500 10/17/2000, Benjamin Herrenschmidt wrote:
>>It might not work as you want for dual booting, but you might want to
>>try OF booting with quik. It's rather manual, but it may bring up your
>>second processor...
>
>Yup, try miBoot or quik. The problem here is that new versions of MacOS
>have a small SMP nanokernel that is taking over the second CPU before
>BootX can react.

Ah, that would appear to be it. I booted with an 8.1 CD + BootX and I get
the full twin-penguins and everything. Spiff.

I would think it should be possible to have BootX hijack the second CPU in
a way that would make it un-stuck-able for when linux starts. I'd do this
myself but BootX doesn't build in MPW and I don't have codewarrior.

As much as I hate codewarrior, anyone care to make a donation? :)


merida:~$ cat /proc/cpuinfo
get_cpuinfo(): ran out of cpu nodes.
processor	: 0
cpu		: 604e
clock		: 200MHz
revision	: 2.2
bogomips	: 398.95

processor	: 1
cpu		: 604e
clock		: 200MHz
revision	: 2.2
bogomips	: 398.95

total bogomips	: 797.90
zero pages	: total 0 (0Kb) current: 0 (0Kb) hits: 0/282 (0%)
machine		: Power Macintosh
motherboard	: AAPL,9500 MacRISC
L2 cache	: 512K unified
memory		: 64MB
pmac-generation	: OldWorld
get_cpuinfo(): ran out of cpu nodes.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
