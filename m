Message-ID: <383D92CF.6ECD12D3@netx4.com>
Date: Thu, 25 Nov 1999 14:49:35 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Christian Zankel <chris@mvista.com>, cort@fsmlabs.com,
        linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
References: <Pine.LNX.4.05.9911251809390.7807-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:


> Alternatively, you can base your decisions on specific features that are shared
> among different machine types, and say
> 
>     if (has_feature_a) {
>         ...
>     }
> 
> instead of
> 
>     #if defined(CONFIG_x) || defined(CONFIG_y) || defined(CONFIG_z)
>     ...
>     #endif


Yes, but one of the things I am trying to do is reduce the
code size and instructions to execute.  On a 500 MHz G4 with
a Gigabyte of memory, a few extra instructions is no big deal.
On a 33 MHz 8xx with 8 Mbytes of memory, you watch all of this
pretty closely :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
