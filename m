Date: Tue, 24 Feb 2004 16:42:26 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Gardiner <daveg@sonartech.com.au>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ppcbug booting
Message-ID: <20040224164226.D13974@home.com>
References: <403BDD46.8070004@sonartech.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <403BDD46.8070004@sonartech.com.au>; from daveg@sonartech.com.au on Wed, Feb 25, 2004 at 10:24:54AM +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Feb 25, 2004 at 10:24:54AM +1100, David Gardiner wrote:
>
> Hi All,
>
> I'm currently running Linux system (linuxppc_2_4 from monta vista,
> thanks to all those who have worked on it) that comprises of a motorolla
> mvme5100 that has a promise ide pmc with a compact flash and was hoping
> to get the compact flash to hold the entire OS+kernel ... At the moment
> the system can be booted via nfs / prep boot (if running with a scsi
> disk) and bugboot. But what I was hoping to do was boot of a kernel on
> the compact flash. My assumption is that using u-boot to do this would
> be a heavy handed approach (please point out if I'm wrong) and I haven't
> seen anything in my googling. Has anyone ever tried anything like this?
> if not can I please get some pointers on the best way to go about this.

You can't do this from PPCBUG's PBOOT command.  It only knows about
on-board IDE interfaces (on the MCG boards that have IDE on-board) and
any SCSI interfaces. You need new firmware (u-boot), a secondary bootloader
(to use via bugboot), or something like boot image to switch kernels
without rebooting through the firmware.  Your best bet is the first
option, do it right and port/put u-boot on the board.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
