Message-ID: <20030614181357.55542.qmail@web41503.mail.yahoo.com>
Date: Sat, 14 Jun 2003 11:13:57 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: Problem in booting kernel
To: j.rakesh@gdatech.co.in, linuxppc-embedded@lists.linuxppc.org
Cc: j.rakesh@gdatech.co.in
In-Reply-To: <1iiwzz6cccr670f.140620031003@gda-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jagota

If u see ur ppcboot messages carefully. u will see

 avail ram:     004AE000 04000000 ->64 MB


It means ur PPCboot is understanding that u have 64MB
of SDRAM but really u have 32MB of SDRAM.

Try to resolve this issue in PPCBOOT first. then
things may become OK.


Thanx
Bhupi
linux+Hypertransport --> Silicon
www.gdatech.com




--- Rakesh jagota <j.rakesh@gdatech.co.in> wrote:
>
> Hi all,
> I am working on custom design board based on IBM405
> PPC. I am using OpenBios
> code and Linux -2.4.17 version from montavista. I am
> downloading the os image
> using serial port. After downoading the image, I am
> getting the follwoinbg
> messeges:
>
>
>
=========================================================================
>
>
> Loaded successfully ...
> Entry point at 0x500000 ...
>
> loaded at:     00500000 005AD1F8
> relocated to:  00400000 004AD1F8
> board data at: 004AA128 004AA168
> relocated to:  00405544 00405584
> zimage at:     00405BA0 004A9671
> avail ram:     004AE000 04000000
>
> Linux/PPC load: console=ttyS0,9600
> Uncompressing Linux...
>
> opps... out of memory
> pause
> opps... out of memory
> pause
> opps... out of memory
> pause
> opps... out of memory
> pause
> opps... out of memory
> pause
> opps... out of memory
> pause
> opps... out of memory
> pause
> opps... out of memory
> pause
> opps... out of memory
> pause
> opps... out of memory
> pause
> done.
> Now booting the kernel
>
========================================================================
>
> And after this it stops.
>
> Can anyone suggest me how to resolve this problem. I
> am using 4MB flash. And
> Single SDRAM with single bank  of size 32MB. Can
> anyone helpme out to sort
> out this issue.
>
> Thanks & Regards,
>
> rakesh
>
>


SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
