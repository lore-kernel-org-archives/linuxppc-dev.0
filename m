Date: Fri, 17 Oct 2003 12:06:52 +0200
Message-ID: <3F710B1D000897FA@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <1066381142.735.75.camel@toni>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: RE: Doing floating point calculations in kernel space
To: t.vanremortel@ha.be
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>-- Original Message --
>Subject: RE: Doing floating point calculations in kernel space
>From: Toni Van Remortel <t.vanremortel@ha.be>
>Reply-To: t.vanremortel@ha.be
>To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
>Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
>Date: Fri, 17 Oct 2003 10:59:29 +0200
>
>
>Op vr 17-10-2003, om 09:52 schreef Toni Van Remortel:
>> Op vr 17-10-2003, om 09:33 schreef Wolfgang Grandegger:
>> >  ftp://ftp.denx.de/pub/RTAI/contrib/fp_ppc_8xx.tar.bz2
>> > It links statically with the libm and the soft-float
>> > library derived from libgcc.
>> >
>> > Hope it's useful.
>>
>> Seems useful. Let's check it out deeper and implement it into my module.
>> I'll keep you informed.
>
>It compiles, it runs. Very nice. Thank you a lot for the example. I had
>only to add the extra linking to my compile command.

Unfortunately, this soft-float implementation from GCC is very
very slow :-(. I'm just doing some benchmarking with soft-float
on IBM 405 and compare the result with the soft-float library
provided by VxWorks. And a simple add (__adddf3) is approx. 5
times faster on VxWorks. And a look to the assembler code makes
clear why. Has anybody else on this list made similar experience
or it there a better free implementation? Has this been improved
in GCC >= 3.2.

Thanks.

Wolfgang.

Wolfgang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
