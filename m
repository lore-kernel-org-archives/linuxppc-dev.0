Subject: Re: Porting LinuxPPC
To: Daniel.Wu@alcatel.com.au (Daniel Wu)
Date: Fri, 19 May 2000 15:10:50 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <00May19.143130est.115267@border.alcanet.com.au> from "Daniel Wu" at May 19, 2000 02:31:30 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000519051051.236093C972@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Daniel,

Daniel Wu writes:
> I compiled the mpc8xx-2.2.13 sources using the attached configuration for a
> MPC860T based board with 32MB of RAM. The output vmlinux file was downloaded
> to the target using a BDM debugger. I changed the KERNELLOAD and KERNELBASE
> to 1000000 instead of c0000000 so that the code is located at the start of
> the 16MB region.

To quote Grant Erickson in
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200001/msg00123.html:

"You don't ever want to change KERNELLOAD or KERNELBASE, otherwise the
virtual memory and MMU code will all break."

This seems to be a common error, so I might add mention of it in the HOWTO.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
