Message-Id: <3.0.3.32.20020929071746.006f7bc8@hollabaugh.com>
Date: Sun, 29 Sep 2002 07:17:46 -0600
To: Wolfgang Denk <wd@denx.de>,
	"Luo Yanjun" <linux_arm_kernel@sohu.com>
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: where does kernel config MPC860 memory controller BRx
  register?
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020929083403.001EAFA8F@denx.denx.de>
References: <Your message of "Sun, 29 Sep 2002 15:23:13 +0800."             <03db01c26789$12dcb5b0$6100a8c0@udtech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:33 AM 9/29/2002 +0200, Wolfgang Denk wrote:
>
>In message <03db01c26789$12dcb5b0$6100a8c0@udtech.net> you wrote:
>>
>> I want to use CS3 of MPC860 for some devices,
>> so I need config BR3 register, I don't know where
>> to config it, I have not find BR0's config code.
>> Where can I find BR0's config code? If I find that,
>> I think I can place my code there.
>
>The initialziation of the memory controller (and things like  testing
>and  sizing available memory) have to be done by the firmware on your
>board, so look in your firmware sources.
>
>For additional chip selects, you can  of  course  add  the  necessary
>BRx/ORx initialization in the init function of the device driver that
>will be accessing this hardware.


Here's some example code for CS5 device driver init

http://www.embeddedlinuxinterfacing.com/sourcecode.shtml

Look at chapter 9,
helloworldbit_rpxcllf.c

You also need to be looking at the MPC860UM (User manual) at the same time.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
