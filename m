Return-Path: <adgospod@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.198])
	by ozlabs.org (Postfix) with ESMTP id 53D3867B1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 08:30:06 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so9193nzh
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 15:30:05 -0700 (PDT)
Message-ID: <bdfc5d6e0609191530y34d37905jdd97888085214bf0@mail.gmail.com>
Date: Tue, 19 Sep 2006 18:30:04 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Steven Hein" <ssh@sgi.com>
Subject: Re: JTAG debugger for MPC82xx/MPC83xx
In-Reply-To: <4510664B.2020304@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4510664B.2020304@sgi.com>
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

On 9/19/06, Steven Hein <ssh@sgi.com> wrote:
> Hi,
>
> My group is starting a new project includes a custom board
> with an MPC8258E processor on it.   I'm in the process
> of evaluating the state of the Linux kernel, toolchains,
> etc. for the MPC8258E/MPC8360E, as well as selecting a
> JTAG debugger for our project.
>
> I've been researching the available JTAG debuggers that
> support the MPC82xx/MPC83xx family, and I've found these
> choices so far:
>
> * Abatron BDI-2000
> * Green Hills Probe
> * Freescale's PowerTAP PRO for PowerPC
> * Lauterbach TRACE32-ICD
> * WindRiver ICE
> * Embedded Toolsmiths Guardian-SE (BUT...this is no longer
>   being sold, according to an email response I received
>   from Embedded Toolsmiths)
>
> We will definitely want one with a network connection,
> and will will run the debugger software from a Linux host.
> Ideally, we would also like one that provides a library
> to allow us to write apps to function the debugger.
>
> Can anyone comment on what JTAG debugger they are using,
> and how have your experiences been?   Are there any other
> good options besides the ones mentioned above.
> I'd appreciate any input.
>
> Thanks!
> Steve
>
> --
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
> Silicon Graphics, Inc.
> 1168 Industrial Blvd.                 Phone: (715) 726-8410
> Chippewa Falls, WI 54729              Fax:   (715) 726-6715
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


I've used the BDI on 82xx, 85xx, 83xx, and othersfor custom board
bringup and I liked it.  Some may not like the command line interface,
but I found it quite easy to use.  I was able to use remote gdb to
debug u-boot, the Linux kernel, and with some trickery userspace apps.

I can't comment specifically on the others (though I have seen some WR
and Lauterbach debuggers and didn't like the user interface), but I
would still recommend the BDI.
