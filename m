Message-ID: <3ECA67C0.5070306@mvista.com>
Date: Tue, 20 May 2003 10:37:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: dong in kang <dkang@east.isi.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel parameters (Sandpoint X3 with Altimus MPC755)
References: <001301c31ef4$cc2cafc0$45a97241@Minjoo>
In-Reply-To: <001301c31ef4$cc2cafc0$45a97241@Minjoo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dong in kang wrote:

> Hello,
> I'm trying to boot Montavista Linux kernel on Sandpoint X3 with Altimus
>MPC755 CPU without bootloader and without using DINK32.
>(I'm using BDI2000 with Metrowerks Codewarrior v.6.0).
>
What do you mean when you say, "I'm using BDI2000 with Metrowerks
Codewarrior v.6.0"?

>I could read/write SDRAM before manually loading zImange.initrd.
>However, I don't know how to setup kernel parameters and command lines.
>What information should I put for kernel parameters? and where?
>
>
You shouldn't need any cmdline arguments unless you're doing something
special.  If you are, look in Documentation/kernel-parameters.txt for
more info.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
