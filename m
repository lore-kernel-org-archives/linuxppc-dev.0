Message-ID: <011d01c01179$fe249820$0401a8c0@hoangmobile>
From: "Nguyen Xuan Hoang" <hoang_nguyen@smartstors.com>
To: <cal_erickson@mvista.com>
CC: <linuxppc-embedded@lists.linuxppc.org>, <support@mvista.com>,
        "Jeff Maddox" <support@hmi.com>
References: <00ba01c00f0c$abd41100$0401a8c0@hoangmobile> <39A6E93C.54BA9C60@mvista.com>
Subject: Re: BDM problem
Date: Mon, 28 Aug 2000 22:28:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Thank very much for your info.  I have verified myself and ask one of my
colleague to double check it, but the Kernel Hacking is already disabled.
However it seems there's some thing relate to your supposition, I can run
the kernel without stopping BDM by command:
         g 100000 (or any random  number).

That's fine for me at this time, but it's still a question : BDM problem or
kernel problem?????

Another problem I have is:

    - After the kernel initializing and running,  if I stop the BDM to view
some registers and start again. The BDM will stop and report an breakpoint
happen if I try to press any key on terminal.  Any advices ???

Thank in advances
Hoang



----- Original Message -----
From: "Cal Erickson" <cal_erickson@mvista.com>
To: "Nguyen Xuan Hoang" <hoang_nguyen@smartstors.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>; <support@mvista.com>; "Jeff
Maddox" <support@hmi.com>
Sent: Friday, August 25, 2000 2:46 PM
Subject: Re: BDM problem


>
> Hoang,
> When you are trying to use the Avocet Systems HMI BMD device
> have you built a kernel with Kernel Hacking disabled? It appears
> from your description the it is still enabled. When kgdb is enabled
> through kernel hacking, it starts and immediately hits a breakpoint.
> If you at this time set a breakpoint further on then you should be
> able to proceed. If you want to use the HMI BMD then you need
> to un-select kernel hacking and rebuild your kernel.
> Cal Erickson
>
> Nguyen Xuan Hoang wrote:
>
> > Hi All, I have problem when running Linux kernel using BDM. It seems
> > not a new problem, from this mail list I can learn some thing: Before
> > run the debugger:
>>        - Set DER to 0 using BDM command:
> >                         X  DER
>>                           30002400f
>>                           0
>>       -  Set ICTRL to 7 using BDM command:
>>               X ICTRL
> >             00000000
>>              7
>>        -  Run the debugger: g
>>    However, the BDM auto stop right after the kernel execute: (perhaps it
turn on the virtual
> > mode here)
>>             execve("/sbin/init",argv_init,envp-init);  in file
/init/main.c
>>    The BDM show that an breakpoint occur (the PC = 0xFEEDDA8),but of
course I didn't set any breakpoint.

>> My system is: RPX LITE + HMI BDM + SOURCE GATE II Could anyone please
point me a
> > solution.
>> Thank in advances
>>  Hoang
>
> --
>
===========================================================================
> Cal Erickson                 MontaVista Software Inc.
> Customer Support Engineer    490 Potrero Avenue
> Phone (408) 328-0304         Sunnyvale CA 94085
> Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
> Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
> web http://www.mvista.com    support e-mail: support@mvista.com
> eCode: http://cal@work.com.ecode.com
>
===========================================================================
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
