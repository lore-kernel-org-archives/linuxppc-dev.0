Date: Fri, 19 Dec 2003 16:31:00 +0100
From: Wouter Cloetens <wouter@mind.be>
To: linuxppc-embedded@lists.linuxppc.org
Cc: v2p@mind.be
Subject: Re: [PATCH] Insight Memec Virtex-II Pro Development Board support
Message-ID: <20031219153100.GA15181@roadkill.intern.mind.be>
References: <20031212215601.GH3935@roadkill.intern.mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031212215601.GH3935@roadkill.intern.mind.be>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 12, 2003 at 10:56:01PM +0100, Wouter Cloetens wrote:
> Mind is making available a set of Linux kernel patches adding support for the Insight
> Memec Virtex-II Pro Development Board using Memec's reference design for Linux on
> ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4_devel/.

[...]

> The patches should be applied in the following order:
>  ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4_devel/patch-platform-insightv2pro
>    board-specific platform support
>    patch for the 405D5X[12] CPU_212 bug (see http://support.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=1&iCountryID=1&getPagePath=14052)

I've updated this file and patch-defconfig because:
- It's not actually the CPU_212 erratum, but the solution 12 one below.
  I got confused by the layout. I've renamed the config option
  accordingly.
- The problem is apparently only present on a small subset of
  early-release Virtex-II Pros. So I've made the option configurable,
  and disabled by default, instead of always enabling it for the
  Memec board.

Sorry about that. I should've read the '4xx Ports' thread on this list
a few weeks ago that discussed the issue.

--
There are 10 types of people in the world: Those who understand binary, and those who don't.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
