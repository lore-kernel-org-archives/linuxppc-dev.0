Date: Tue, 9 Jan 2001 10:23:09 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: menuconfig for PPC860T
In-Reply-To: <20010109082428.D26544@opus.bloom.county>
Message-ID: <Pine.GSO.4.21.0101090955400.18580-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 9 Jan 2001, Tom Rini wrote:

> The 8xx targets are known to build, and should be working.  If you have
> to fix any problems, please send patches.
>

For about the last week, make xconfig has stopped working for the
EST8260 board in the 2.5 bk tree.  It dies with:

make[1]: Entering directory `/home/ford/linux/src/linuxppc_2_5/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/ppc/config.in >> kconfig.tk
statement not in menu
make[1]: *** [kconfig.tk] Error 1

This happens whether or not I use my .config or I remove it.  With my
.config, I can still successfully build a kernel.  I haven't taken the
time to track it down as I assumed it was transient.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
