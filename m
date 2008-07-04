Return-Path: <dhbaird@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id 6BC74DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 12:02:42 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1060084rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jul 2008 19:02:40 -0700 (PDT)
Message-ID: <440abda90807031902u766eb4dby932e8741e947488e@mail.gmail.com>
Date: Thu, 3 Jul 2008 20:02:40 -0600
From: "David Baird" <dhbaird@gmail.com>
To: "Lorenzo T. Flores" <lorenzo@alphagolf.com>
Subject: Re: booting an ML405
In-Reply-To: <486D774A.7000102@alphagolf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486D774A.7000102@alphagolf.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 3, 2008 at 7:05 PM, Lorenzo T. Flores <lorenzo@alphagolf.com> wrote:
> I'm trying to compile the Xilinx patched kernel tree (v2.6.25-rc9) and run
> it on an ML405
>
> So far, I get to the following point in the boot sequence:
>
> loaded at:     00400000 005AF5A0
> board data at: 005AD524 005AD5A0
> relocated to:  00405058 004050D4
> zimage at:     00405E90 0051D6CC
> initrd at:     0051E000 005ACC0D
> avail ram:     005B0000 80000000
>
> Linux/PPC load: console=ttyS0,9600 ip=on root=/dev/ram rw
> Uncompressing Linux...done.
> Now booting the kernel
>
> The system hangs after it says "Now booting the kernel."

This seems to come up a lot, so I'm surprised you didn't find it in
the archives ;-)

Are you using uartlite?  You'll need to change the "console" option if you are.

-David
