Message-Id: <200402161059.i1GAxDqA002613@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: Wolfgang Denk <wd@denx.de>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Re: Sandpoint problems
Mime-Version: 1.0
Content-Type: text/plain
Date: Mon, 16 Feb 2004 18:59:34 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk:
   Sorry about this mess.
  ======= 2004-02-16 10:35:00 Origianl message=======

>In message <200402160051.i1G0pKqA003808@ms.usish.com> you wrote:
>>
>>   I am planning to use U-Boot to replace DINK13 shipped in
>> Sandpoint platform. I got a sucessful compilation by: Make
>> Sandpoint8245_config, Make all . Then I Burn u_boot.src in the Boot
>> ROM. IT CAN'T BOOT. I used all default setting in the PrPMC8245 and
>> Sandpoint board. I didn't know the reason. Anybody knows?
>
>First, this is off topic on the linuxppc-embedded list. Please send
>U-Boot related questions to the u-boot-users list. Thanks.

  Sorry about this mess.

>What exactly did you do? "I Burn u_boot.src"? There is no file
>u_boot.src. Do you mean u_boot.srec? Note that this is a S-Record file
>- are you sure you need to use the S-record file?

 I used u_boot.srec. To program flash, it will first be converted to
binary file.

>Where exactly in flash did you program it? How did you verify that the
>flash programming worked?

 I loaded u_boot in the bootrom of sandpoint board. And the same method
was used on DINK.

>And what exactly do you mean by "it can't boot"? (An why are you
>shouting?) Is the board completely dead? Is there Some output? Which?
>Does U-Boot run, but fails to boot Linux? Or what?

    PCI LED on the board is active continuously.Yet no output. u-boot
can not boot. Did I miss anything?

= = = = = = = = = = = = = = = = = = = =

Best regards
Jack

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
