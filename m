Message-ID: <3E2E5E8D.2000803@tataelxsi.co.in>
Date: Wed, 22 Jan 2003 14:34:13 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot for mpc8260ads board.
References: <65256CB6.0030533A.00@sandesh.hss.hns.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI,
I don't think the vmlinux at 0x0 will work. I tried the same with little
success. finally we settled for ppcboot. now I am on the process of
making the board up.
Some parameters are to be passed from the boot loader to the OS. ( what
are they?) Moreover ramdisk loading must be done by boot loader.
This is what I know. if I am wrong, please correct me.
regards,
om.

vnair@hss.hns.com wrote:
>
> Hi,
>
> Can you pls give some insight what soln worked for you. Was it using BDI or you
> ported ppcBoot.
>
> I am trying to put ppclinux onto IBM spruce reference board (MPC750). Although
> linuxppc-2.5 tree has the support for this board, but i am not able to finalize
> my way for the initial success.
>
> I have a JTAG (VisionProbe) to download the image.
>
> Can you please list some steps to proceed. I have the kernel and the build
> environment ready. I am thinking of building vmlinux (uncompressed) and
> downloading it @ address 0x0 on the board. Will it work ?
>
> Thanks
> - Vikram
>
>
>
>
>
> "Omanakuttan" <omanakuttan@tataelxsi.co.in> on 01/22/2003 02:17:52 PM
>
> To:   linuxppc-embedded@lists.linuxppc.org
> cc:    (bcc: Vikram Nair/HSS)
>
> Subject:  Re: ppcboot for mpc8260ads board.
>
>
>
>
>
> Please ignore my question. I got it up.
>
> Omanakuttan wrote:
>
>>Hi,
>>I got my bdi2000, thanks to the cogent arguments supplied by WD.
>>
>>Facing a problem.
>>1. Is it required to install ppcboot in an mpc8260ads board? If I make a
>>make bzImage , can the resultant image be directly loaded to flash and
>>start running it? the bdi2000 guys says that it is not possible. Is it so?
>>Does it mean that we have to port ppcboot and put it in out end product
>>for loading linux? we have only 8MB of flash.
>>
>>2. I tried to coross compile ppcboot for mpc8260ads board.
>>make mpc8260ads_config does not work. In the readme, no such target is
>>supported. but in the  boards directory, there is a file for mpc8260ads
>>boards. I am confused and reading the makefile. But seems like a little
>>complex. if anybody can throw some light on compiling ppcboot for
>>mpc8260ads, it would be a great help.
>>
>>Thanks
>>Om.
>>
>>
>>
>>
>
>
>
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
