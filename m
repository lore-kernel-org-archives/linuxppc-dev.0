Date: Tue, 13 Nov 2001 08:57:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ole Andreas Torvmark <ole.torvmark@radionor.no>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling linux-2.4.devel on a sandpoint
Message-ID: <20011113085723.D16723@cpe-24-221-152-185.az.sprintbbd.net>
References: <MHEAIGEFFBAFIOMKCIGCEEKACAAA.ole.torvmark@radionor.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MHEAIGEFFBAFIOMKCIGCEEKACAAA.ole.torvmark@radionor.no>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 13, 2001 at 04:28:53PM +0100, Ole Andreas Torvmark wrote:

[snip]
>  arch/ppc/platforms/platform.o: In function `lookup_partitions':

Did you turn on CONFIG_NVRAM?  CONFIG_NVRAM is a powermac-only driver as
it stands under CONFIG_PPC.

[snip]
>  fs/fs.o: In function `cpuinfo_open':
>  fs/fs.o(.text+0x2453a): undefined reference to `cpuinfo_op'
>  fs/fs.o(.text+0x2453e): undefined reference to `cpuinfo_op'

Sandpoint needs to be updated to the new cpuinfo stuff.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
