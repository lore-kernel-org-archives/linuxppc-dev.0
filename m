Message-Id: <200010050957.LAA11783@denx.local.net>
To: Daniel Furse <daniel.furse@iptest.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded planet CLLF boards 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 05 Oct 2000 09:47:05 BST."
             <0D9416AE7F95D411A8710008C7332F3F0E0A@GUILDFORD4_NT>
Date: Thu, 05 Oct 2000 11:57:22 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0D9416AE7F95D411A8710008C7332F3F0E0A@GUILDFORD4_NT> you wrote:
>
> I am currently assessing the options for a real-time embedded linux
> controller, based on a PowerPC 860T chip.

Interesting... Do you have RT-Linux or  RTAI  already  running  on  a
MPC8xx? This is something we still have in the queue, but we're stuck
with problems very early in interrupt handling...

> with this target. Can anyone recommend an 860T-based board, which has
> both a fast ethernet and a PCMCIA interface? So far, the board that gets
> closest to this spec is the embedded planet CLLF board. However, this is
> a production-ready board, and we are looking to design our own product
> once we have proven the technology can do the task.

Maybe the TQM8xxL modules can be used. You could use the starter  kit
STK8xxL  for  development,  and  maybe use the TQM8xxL module in your
product. See http://www.denx.de/embedded-ppc-en.html for images,  and
let me know if you want a quote on prices.

The starter kit comes with full documentation so thatit's pretty easy
to build your own carrier board where  you  can  plug  in  a  TQM8xxL
module;  the design module itself is not available for free, but this
can be negotiated, too. Just let me know what you need.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Use C++ to confuse your enemies; use C to produce stable code.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
