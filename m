Return-Path: <arnd@arndb.de>
Message-Id: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:44:54 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 00/22] Cell patches for 2.6.20
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to flush my patch queue again for 2.6.20, this is
most of what has been coming in since the last submission
to powerpc.git. Please review for inclusion in powerpc.git.

As a quick overview, the patches contain:

* new spufs file interfaces to support more gdb functionality,
  to look into the state of various HW registers without changing
  data.
* core dump support for SPUs. When core dumping a task that has
  created SPU contexts, information about them will be included
  in the dump.
* A rework of the SPU HW isolation support. Reusing an isolated
  SPU for another program now doesn't require a new spufs interface
  any more, which simplifies the implementation significantly.
* A new oprofile model for using the profile event mechanism on
  the Cell Broadband Engine. This is only for PPE profiling so far,
  profiling SPU code is still work-in-progress.
* Lots of bug fixes.

I have some other patches in my cell kernel tree currently, which
I'm not submitting myself, because I assume they will find their own
way into the kernel:
* Patches to the spidernet driver, these go through netdev
* Support for the Playstation 3, the patches are currently under
  discussion, and I expect that Paul will take them directly once
  they are done.
* xmon add-ons for debugging with SPUs. Waiting for a new version
  to be submitted.

	Arnd <><
