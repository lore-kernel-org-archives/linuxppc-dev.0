Message-ID: <007101c38964$61f29a90$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20031002121733.A2E32C59E4@atlas.denx.de>
Subject: Re: Queston about Walnut 
Date: Fri, 3 Oct 2003 12:11:06 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


        I trace the code in kernel and I found some strange behaviors.
        In the first case (using walnut_config provided in kernel source),
kernel hangs at mapin_ram();
        However, if I turn off all unnecssary options and leave only serial
console, my kernel can run until init/main.c: kmem_cache_init();

        As both hangs in memory related function, I tried to run a memory
test on my board in u-boot. But it hangs.

        => mtest 0 3ffffff
        Pattern 00000000  Writing...
        <hangs>

    I tried smaller range (ffffff), it still hangs.

    I am sure my board's memory is in good condition because VxWorks can run
very well on it. Have any idea? Thanks.

Best regards,
Jacky





----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "Jacky Lam" <jackylam@astri.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, October 02, 2003 8:17 PM
Subject: Re: Queston about Walnut


>
> In message <000e01c388dc$eb525510$0202a8c0@homevl9biy3v7e> you wrote:
> >
> > > Who gave you such (obviously wrong) instructions?
> >
> >         I take the example of u-boot to create the "uImage" and download
it
> > to the board.
>
> Please show me which U-Boot document uses 0x00400000 as load or entry
> point address so I can fix this immediately. It is WRONG  and  CANNOT
> work.
>
> > > For PowerPC systems, both  Load  Address  and  Entry  Point  must  be
> > > specified as 0.
> >
> >         I have tried 0 before. But I get an exception in return. Could
you
> > kindly give me some instructions how to run a kernel on this board?
>
> Please start by giving a precise description of  what  you  did.  and
> which error messages you got.
>
> You "get an exception" - when? When running "mkimage"?  When  booting
> the kernel? Which sort of exception? What is the exact error message?
> Please include a complete log of your actions and all output.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Totally illogical, there was no chance.
> -- Spock, "The Galileo Seven", stardate 2822.3
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
