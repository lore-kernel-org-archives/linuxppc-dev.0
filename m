Message-ID: <XFMail.010312125719.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Date: Mon, 12 Mar 2001 12:57:19 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [OT] 7450
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Giuliano Pochini wrote:
>> >
>> > I read many msg about 7450 performance problems.
>>
>> From who?  People that are actually running hardware or
>> speculating from rumors based on documentation that doesn't exist?
>>

>There are some Mac benchmarks flying around, which don't make the 7450
>look all too good.
>[...]
>But at least one issue remains, and that is surprisingly low FP performance.
>This was measured with one ray tracing application and with an MP3 coder.
>I currently believe that thus far, no PPC compiler has made much effort
>schedule FP operations. With just three cycles of latency for a
>multiply-add, you can get away with rather sloppy code (in fact, I know
>of no shorter FPU pipeline in any other CPUs that reach comparable clock
>speeds).

>But with five cycles of FP latency, scheduling becomes really important.

Hmm, probably soft compiled for 604 runs fine on 7450 because it had
similar latencies and a 6-stage pipeline.

>> > .... Will GCC have optiminazions
>> > (workarounds?) for the 7450's longer pipeline ?
>>
>> People are working on it.

>These aren't really "workarounds". Nowadays CPU architecture and compiler
>capabilities have to be regarded together. It may well be the case that
>the chip designers made a sound decision to move certain complexities to
>the software side rather than to the hardware side.

Yes, but it's not a good thing. People cannot recompile their software.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
