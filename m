To: "Christian Meyer" <Christian.Meyer@cs.tum.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC7410 doesn't work with linux-2.4.20-denx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 14 Aug 2003 13:28:50 +0200."
             <200308141128.h7EBSnQ06089@mailgate5.cinetic.de>
Date: Fri, 15 Aug 2003 10:42:10 +0200
Message-Id: <20030815084215.BE92CC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Christian,

in message <200308141128.h7EBSnQ06089@mailgate5.cinetic.de> you wrote:
>
> I'm currently trying to get linux running on an embedded board:
> 	* MPC7410 Rev.1.4
> 	* PowerQUICC (MPC 8260)
> 	* RAM: 128 MB
> 	* Flash: 64 MB
> 	* Kernel: 2.4.20-denx
>
> For some reason, it doesn't boot properly. It says "Now booting Linux",
> after that something triggers a hard reset. For the last 2 weeks I tried

A couple of questions:

* Which bootloader are you using?
* Are you sure that the SDRAM initialization is correct?
* Are you sure the information passed from the bootloader to the Linux
  kernel (memory size, clocks, ...) is correct?
* Finally: did you disable the software watchdog?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you fail to plan, plan to fail.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
