Subject: Re: 2.4.21-ben2 issues: RTC, Thermal and RTAS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Debian PowerPC List <debian-powerpc@lists.debian.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.58.0401181310240.2808@waterleaf.sonytel.be>
References: <20030823171845.GA1963@dat.etsit.upm.es>
	 <20031217011849.GA26643@iliana>
	 <Pine.GSO.4.58.0312171042530.24864@waterleaf.sonytel.be>
	 <20031217095241.GD2283@iliana>
	 <Pine.GSO.4.58.0312171056030.24864@waterleaf.sonytel.be>
	 <20031217100358.GA2655@iliana>
	 <Pine.GSO.4.58.0312171112040.24864@waterleaf.sonytel.be>
	 <20040113151230.GA12089@iliana>
	 <Pine.GSO.4.58.0401131806560.9060@waterleaf.sonytel.be>
	 <20040113171606.GA13923@iliana>
	 <Pine.GSO.4.58.0401181310240.2808@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1074468347.813.33.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 10:25:47 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> To my surprise, genrtc in 2.4.23 does not work on my LongTrail!
> The kernel crashes in init/do_mounts.c:mount_block_root() right after the call
> to sys_chdir(), because current->fs is a NULL pointer. Weird, and it doesn't
> really look genrtc-related, although the same source tree works fine if I
> disable genrtc and build in rtc.
>
> I also tried 2.6.0, and there it works fine, both in the builtin and modular
> case: the kernel got the correct time, and hwclock works.

Debuggin that would be useful... memory corruption caused by genrtc ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
