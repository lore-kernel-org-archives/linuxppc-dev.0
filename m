To: wung_y@263.net
Cc: linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: TiVo Kernel for 403GCX Update (was Re: Support for IBM CPUs?)
References: <Pine.SGI.4.10.9910222012050.46619-100000@brule.lcse.umn.edu> <3812E624.BF756DFF@263.net>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Oct 1999 16:33:17 +0200
In-Reply-To: Wang Yong's message of "Sun, 24 Oct 1999 18:57:40 +0800"
Message-ID: <kfyn1t7qzma.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wang Yong <wung_y@263.net> writes:

> Hi,
>   It appears you compiled this kernel with GCC, so i am wondering if
> GCC could work correctly with some architecture specified instructions
> of
> PPC embedded controller? Do you know if GCC could compile the kernel
> written
> for 401D2, another embedded controller from IBM?

>From a quick look at the source GCC and binutils seems to know about
401 CPUs, so there shouldn't be any problem compiling/assembling code
for this CPU.

> this is very important for
> us because we're starting to port linux to this platform(RedWood3) but
> we still don't know which compiler should be ok.

If GCC hadn't supported this particular PowerPC CPU it would probably
have been easier to add support for it to GCC and binutils than to
port Linux to a non-GCC compiler...

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
