Message-ID: <3CC8786C.947A52F1@mvista.com>
Date: Thu, 25 Apr 2002 17:43:08 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Stephen Noftall <stephenn@lcsaudio.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using 2_4_devel to build a kernel for the 8240
References: <002401c1eca1$c8260830$61012ac7@snbeast>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephen Noftall wrote:

> Hello;
>
> I am using the latest bitkeeper PPC 2_4_devel kernel, and want to configure it
> for the 8240.
>
> When I run menuconfig, I can see "Sandpoint X3" and "8260" selections, but no
> 8240 specific selections.
>
> What options should I select to enable 8240 support? I am guessing "Sandpoint
> X3", is this right?

No.  "Sandpoint" is a platform, not a processor.  You select the processor from
inside "Platform support"/"Processor Type".  Since the 8240 is essentially a 603
core with a 107 bridge, select "6xx/7xx/74xx/8260" for your processory type.

You probably want to make a new "Machine Type" for your board/platform and select
it.  Look in arch/ppc/platforms and arch/ppc/config.in for lots of examples.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
