Message-ID: <392AF1A1.892D5886@motorola.com>
Date: Tue, 23 May 2000 16:01:21 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting LinuxPPC
References: <20000519051051.236093C972@elph.research.canon.com.au> <39253A48.24B90117@snmc.com> <39253D0B.F9AF86EE@raleigh.ibm.com> <392562CE.A71A4F49@embeddededge.com> <00May23.171838est.115222@border.alcanet.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Are you using a custom UPM table?  This can happen when your UPM burst
table is not proper.  Since bursts are not used by the core until
caching is disabled, problems usually come from the UPM table.

Daniel Wu wrote:
>
> Hi,
>
> Thanks to all who responsed to my last qeustion. The problem was that the immr
> was not setup correctly. Also since it is a custom board (MPC860T based), I had
> to rewrite code to fill in the bd_t structure. The board is now sending
> characters to the console, which is good but I still have one of the original
> problems: I can only step through the code using the BDM debugger, but when I
> run the code, it generates a software emulation exception and stops.
>
> After some investigation, it seems that I can run the code up to the point
> where the instructure cache is enabled - actually only a few lines at the top
> of the startup code. My question is: are there any restrictions on when the
> cache can be enabled? Are there anything else I've missed.
>
> Thanks,
> Daniel
>

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
