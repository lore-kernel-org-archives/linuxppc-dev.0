Message-ID: <4081CBB0.7090800@jonmasters.org>
Date: Sun, 18 Apr 2004 01:28:32 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: System ACE MPU interface to CF card
References: <407470ED.3030607@buckeye.ece.drexel.edu> <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu> <25757-52278@sneakemail.com> <407EDCF7.2020009@buckeye.ece.drexel.edu> <6334-88322@sneakemail.com>
In-Reply-To: <6334-88322@sneakemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Stephen Williams wrote:

| I have noticed that if the disk does not have a .ace file on
| it, and a Xilinx chip to program, the driver fails to get any
| partition info from the disk and it all fails from there. So
| I suspect the driver still to some degree relies on the state
| of the chip after a successful Xilinx load. If you are trying
| to use the chip without an FPGA attached, you may be running
| into that.

I am having problems with xilinx_sysace at my end. This is on a
non-ML300 which is not running at anything like the same clock as the
rest of you at this moment in time (for various hardware development
reasons unrelated to the Linux side). I have a classic case of debugging
printk code altering the rate of execution and making things work.

Otherwise we get hard lockups and corrupted CURRENT data which has all
the hallmarks of a failure to re-aquire io_request_lock somewhere.

Obviously I will fix this problem soon but if anyone has already caught
this nasty and fixed it then do drop me a line. The driver will need
plenty of cleanup for kernel 2.6. Even then the HAL approach clearly
needs to be replaced also (but I will send an update on that later).

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
