Date: Thu, 30 Mar 2000 14:24:10 +0200
From: Olaf Hering <olh@suse.de>
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Pismo Powerbook
Message-ID: <20000330142410.A29754@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <200003291920.LAA08359@shell1.ncal.verio.com> <20000329183654.D27338@plato.localdomain.local> <38E2DE84.72E7297A@dana.ucc.nau.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38E2DE84.72E7297A@dana.ucc.nau.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 29, Tim Wojtulewicz wrote:

>
> So I take it from this lengthy discussion that there is no concrete list of
> steps to install LinuxPPC on a Pismo Powerbook.  If there is one, could
> someone post it, since my brand spankin new pb is arriving Friday :-).
> Thanks.

Just create four partitions, one for MacOS, one small for Linux Boot in
HFS (32MB), one Linux Swap 128MB, one for Linux.
Then reinstall MacOS and play with it until the new install instructions
arrive at www.suse.com/ppc.


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
