Subject: Re: 2.4.22p10 compile error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>,
	LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20030808170309.GA8475@ip68-0-152-218.tc.ph.cox.net>
References: <20030807232737.20df47f2.pochini@shiny.it>
	 <20030808170309.GA8475@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1060362726.653.5.camel@gaston>
Mime-Version: 1.0
Date: 08 Aug 2003 19:12:07 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It looks like your copy of the rsync tree is missing files.  Please
> update the tree and try again.

My bk clone does that too:

make _sfdep_chrp _sfdep_pmac _sfdep_prep _FASTDEP_ALL_SUB_DIRS="chrp pmac prep"
make[4]: Entering directory `/home/benh/kernels/linuxppc_benh_devel/arch/ppc/boot/prep'
make -C chrp fastdep
make: *** chrp: No such file or directory.  Stop.
make: Entering an unknown directorymake: Leaving an unknown directorymake[4]: *** [_sfdep_chrp] Error 2
make[4]: Leaving directory `/home/benh/kernels/linuxppc_benh_devel/arch/ppc/boot/prep'
make[3]: *** [fastdep] Error 2
make[3]: Leaving directory `/home/benh/kernels/linuxppc_benh_devel/arch/ppc/boot/prep'
make[2]: *** [_sfdep_prep] Error 2
make[2]: Leaving directory `/home/benh/kernels/linuxppc_benh_devel/arch/ppc/boot'
make[1]: *** [fastdep] Error 2
make[1]: Leaving directory `/home/benh/kernels/linuxppc_benh_devel/arch/ppc/boot'
make: *** [archdep] Error 2


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
