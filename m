From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Xavier Grave" <grave@ipno.in2p3.fr>,
	=?ISO-8859-1?Q?Michel=20D=E4nzer?= <michel@daenzer.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 19:39:59 +0200
Message-Id: <20021022174000.3855@192.168.4.1>
In-Reply-To: <200210221537.RAA23935@ipnmail.in2p3.fr>
References: <200210221537.RAA23935@ipnmail.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Not necessarily if you're booting with video=ofonly. cat /proc/fb
>[root@ipnnarval ~]# cat /proc/fb
>0 OFfb /pci@f0000000/ATY,PheonixParent@10/
>
>> > I think support for the 9000 have been added to XFree CVS
>> > recently, though that may not yet be in the DRI one (and
>> > so Michel snapshots). The XFree CVS is beeing merged
>> > again into the DRI one now, so this should be fixed soon.
>>
>> Yep, and in the meantime, you could try telling the radeon driver to
>> treat it like a 8500 with the ChipID or Chipset directive.
>What do I need to put ? There is 4 different RADEON 8500 ?

Ok, this is offb, so you don't have radeonfb. Another user
is reporting me that radeonfb doesn't work on your card.

I'll see what I can do.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
