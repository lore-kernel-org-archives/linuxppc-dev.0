Date: Fri, 8 Aug 2003 10:03:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.22p10 compile error
Message-ID: <20030808170309.GA8475@ip68-0-152-218.tc.ph.cox.net>
References: <20030807232737.20df47f2.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030807232737.20df47f2.pochini@shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 07, 2003 at 11:27:37PM +0000, Giuliano Pochini wrote:

> The stable linuxppc_2_4 tree at mvista doesn't compile. make dep fails
> very soon:
>
>
> make _sfdep_chrp _sfdep_pmac _sfdep_prep _FASTDEP_ALL_SUB_DIRS="chrp pmac prep"
> make[4]: Entering directory `/opt/KernelSrc/l/arch/ppc/boot/prep'
> make -C chrp fastdep
> make: Entering an unknown directory
> make: *** chrp: No such file or directory.  Stop.
> make: Leaving an unknown directory
> make[4]: *** [_sfdep_chrp] Error 2
> make[4]: Leaving directory `/opt/KernelSrc/l/arch/ppc/boot/prep'
> make[3]: *** [fastdep] Error 2
> make[3]: Leaving directory `/opt/KernelSrc/l/arch/ppc/boot/prep'
> make[2]: *** [_sfdep_prep] Error 2
> make[2]: Leaving directory `/opt/KernelSrc/l/arch/ppc/boot'
> make[1]: *** [fastdep] Error 2
> make[1]: Leaving directory `/opt/KernelSrc/l/arch/ppc/boot'
> make: *** [archdep] Error 2
> [root@Jay l]#
>
>
> I also tested the official 2.4.22p10 at kernel.org and it works fine, but the
> ethernet.
> I have a dual G4mdd, gcc 2.95.4 (YDL2.3).
> I would like to try linux 2.6. Do I need to upgrade libc and other stuff ?

It looks like your copy of the rsync tree is missing files.  Please
update the tree and try again.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
