Message-ID: <3D3F04F7.1020005@mvista.com>
Date: Wed, 24 Jul 2002 12:50:15 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: akuster@dslextreme.com
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
References: <3D3E4145.8030500@dslextreme.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


akuster wrote:

>
> I was going though some old 4xx kernels I have and found an
> implimentation of idle.c that had support for 4xx.  I believe the reason
> it never made is out was the hacking we did to make it work.  So I
> propose that we modify the kernel/Makefile to use ppc4xx_idel.o instead
> of idle.o when 4xx is configured.  That way we have a clean
> implimentation for 4xx idle functions and not touch the generic ppc idle
> file.  The function names would not change.


Rather than replace the whole idle loop, I would allow for
sub-arch/processor specific code in the idle loop.  Perhaps move the
power_save routine into the platform code?

>
> Armin
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
