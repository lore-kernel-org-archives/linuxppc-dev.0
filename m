Message-ID: <39253A48.24B90117@snmc.com>
Date: Fri, 19 May 2000 07:57:45 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Daniel Wu <Daniel.Wu@alcatel.com.au>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting LinuxPPC
References: <20000519051051.236093C972@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham,

I fell vicitm to the same mistake when I was writing boot code
for MPC850.  I think adding that to the HOWTO is a great
idea.  It would have save me 2 or 3 weeks of effort :-).

Daris Nevil
SiSIC Inc/SNMC


Graham Stoney wrote:

> Hi Daniel,
>
> Daniel Wu writes:
> > I compiled the mpc8xx-2.2.13 sources using the attached configuration for a
> > MPC860T based board with 32MB of RAM. The output vmlinux file was downloaded
> > to the target using a BDM debugger. I changed the KERNELLOAD and KERNELBASE
> > to 1000000 instead of c0000000 so that the code is located at the start of
> > the 16MB region.
>
> To quote Grant Erickson in
> http://lists.linuxppc.org/listarcs/linuxppc-embedded/200001/msg00123.html:
>
> "You don't ever want to change KERNELLOAD or KERNELBASE, otherwise the
> virtual memory and MMU code will all break."
>
> This seems to be a common error, so I might add mention of it in the HOWTO.
>
> Regards,
> Graham
>

--

Daris A Nevil
SiSIC, Inc., f.k.a. Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
