Return-Path: <vsampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id 9948267C76
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 14:04:00 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id p76so235736pyb
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 19:03:58 -0800 (PST)
Message-ID: <758a2bbf0612131903w63a11c60t6f13e68fd3d7e3df@mail.gmail.com>
Date: Wed, 13 Dec 2006 19:03:58 -0800
From: "Vijay Sampath" <vsampath@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: Problem porting linux 2.6 on IBM405EP based boards
In-Reply-To: <458047D3.8060401@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <758a2bbf0612130926w56d468dejf0e8e51c918d2175@mail.gmail.com>
	<458047D3.8060401@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Oh. KGDB. Makes perfect sense. Cool will try to setup a serial
debugger or try and enable printks or try and debug with emulator with
no kgdb. Currently printks don't work (although ppc specific prints
ppc_md.progress() appear on the console). What does it take to get
printk to work early on? Regardless I have enough to proceed now.

Vijay

On 12/13/06, Scott Wood <scottwood@freescale.com> wrote:
> Vijay Sampath wrote:
> > After this, the code started executing start_kernel, but stopped
> > shortly thereafter (snippet B). After this every time I press a key,
> > the following line gets printed:
> >
> > $T0740:30300a00;01:c0621fb0;#45
> >
> > Its possible that I have something configured wrong, but
> > any guidance on what that message could possibly mean would be
> > appreciated.
>
> That looks like output from a GDB stub.  You may want to try turning off
> GDB support in your kernel in order to (probably) get an oops message
> instead (you may need to do something special to hook printk up to the
> early debug console).  Alternately, you could try attaching to it with GDB.
>
> -Scott
>
