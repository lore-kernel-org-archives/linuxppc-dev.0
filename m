Message-ID: <408476A2.2070106@jonmasters.org>
Date: Tue, 20 Apr 2004 02:02:26 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: System ACE MPU interface to CF card
References: <407470ED.3030607@buckeye.ece.drexel.edu> <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu> <25757-52278@sneakemail.com> <407EDCF7.2020009@buckeye.ece.drexel.edu> <6334-88322@sneakemail.com> <4081CBB0.7090800@jonmasters.org>
In-Reply-To: <4081CBB0.7090800@jonmasters.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Jon Masters wrote:

| I am having problems with xilinx_sysace at my end. This is on a
| non-ML300 which is not running at anything like the same clock as the
| rest of you at this moment in time (for various hardware development
| reasons unrelated to the Linux side). I have a classic case of debugging
| printk code altering the rate of execution and making things work.

I received a mail offlist about this concerning the issues with an
earlier revision of the xilinx_sysace driver brokenly not following the
datasheet and failing to hold the device configuration controller in
reset while doing transfers. I have now upgraded to a new verson.

This has fixed the ``hardware seems fairly screwed, it's not giving me
interrupts when I want it! arrrgh!'' type problems but I still get
random lockups and corruption of the request queue, which I think is
related to a missing spinlock aquisition somewhere else.

To be honest I might soon get annoyed enough with it to rewrite it.
Clearly Xilinx think it is a really good idea to have this HAL concept
(and I think it is a really really bad one) - and I am one of the people
that ends up using this code so really want something that works :-).

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
