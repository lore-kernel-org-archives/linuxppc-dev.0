To: caixupeng <edmoon@huawei.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot, linux , hang at the last step 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Nov 2002 18:59:56 +0800."
             <000d01c29471$ca5b94d0$92690b0a@DBKQW41X>
Date: Mon, 25 Nov 2002 17:10:53 +0100
Message-Id: <20021125161058.C3A11C58BF@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000d01c29471$ca5b94d0$92690b0a@DBKQW41X> you wrote:
>
> When I boot a linux image use "bootm ffa00000 ffb00000"
> the linux hang at the last step:
>
> VFS: Cannot open root device "" or 16:01
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 16:01
>
> I have set the "bootargs=root=/dev/ram"

Is this your input, or the putput of the printenv command in PPCBoot?
Remember that you must not use a '=' with setenv!

> Is my linux kernel's erro or ppcboot's problem?

Which arguments are really passed to Linux?  The  kernel  prints  the
boor arguments it receives on the console.

> Does ppcboot send the bootargs to linux kernel correctly?

It does. Probably you did not specifyu correct boot arguments.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You've no idea of what a poor opinion  I  have  of  myself,  and  how
little I deserve it.                                  - W. S. Gilbert

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
