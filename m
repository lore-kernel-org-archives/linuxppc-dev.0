Message-ID: <40845BA6.6010706@buckeye.ece.drexel.edu>
Date: Mon, 19 Apr 2004 19:07:18 -0400
From: Sharad Gupta <sharad@buckeye.ece.drexel.edu>
MIME-Version: 1.0
To: Jeff Angielski <jangiels@speakeasy.net>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: more SystemACE problems
References: <407470ED.3030607@buckeye.ece.drexel.edu>	 <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu>	 <25757-52278@sneakemail.com>  <407EDCF7.2020009@buckeye.ece.drexel.edu>	 <1082322389.23738.13.camel@localhost.localdomain>	 <4084151A.4050805@buckeye.ece.drexel.edu> <1082399912.8706.11.camel@localhost.localdomain>
In-Reply-To: <1082399912.8706.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeff Angielski wrote:
> On Mon, 2004-04-19 at 14:06, Sharad Gupta wrote:
> I would suggest instrumenting the code in the driver that actually
> handles the block request from the kernel.  For instance, is the request
> being received by the xsa_thread?  Is the driver actually making a
> request to the device.  And most importantly and where I suspect your
> problem lies, is the xsa_complete_request() ever getting run?
>
> Jeff Angielski
> The PTR Group

Hi Jeff,

Thanks very much for your help. I have enabled the interrupts for
SystemACE now. And in fact xsa_complete_request() was never called. I
fixed that in xsa_thread.

I was wondering if you could send in your modifications to the
xilinx_systemace/* files so that I can know better where else the
potential problems may lie.

Do I need to have a device entry for xsystemacea (0/1) in my /dev
directory ? If yes, then what should it be like ?

Thanks
Sharad.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
