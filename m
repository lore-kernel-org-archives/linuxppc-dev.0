Date: Thu, 26 Oct 2000 01:37:43 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ThinkPad 850 Patches for 2.2.16
Message-ID: <20001026013743.A30528@suse.de>
References: <20001024200338.A908@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20001024200338.A908@suse.de>; from olh@suse.de on Tue, Oct 24, 2000 at 08:03:39PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 24, Olaf Hering wrote:

> Hi,
>
> Linar Yusupov did some patches for the Thinkpad 850 to make sound work
> on these machines. It fixes also some typos for /proc/cpuinfo.
>
> I'm not sure if the CAROLINA_IRQ_EDGE_MASK_HI change breaks anything else.

linux-pmac-stable works on the TP, but I need a common config.
David Monroes carolina minidif is needed to access the SCSI disks.

I tried to remove that patch with CAROLINA_IRQ_EDGE_MASK_HI, but it
hangs in the cs4231 detection.

I have another strange problem.
The "bootloader" in produces garbage output, it starts with a few random
bytes and then it fills up the screen with more random bytes. These
garbage goes into /proc/cmdline (its hard to copy&paste :):

olaf@tp:~ > hex /proc/cmdline
0000  72 6f 6f 74 3d 2f 64 65  76 2f 66 64 30 bc ad 73
0010  ff bc ad 73 ff bc ad 33  fe 3c ad 73 ff 0a


Any ideas how to fix that? Could be a termic problem, the machine runs
here since a few days. And I cant remember that I got this garbage a few
days ago. But typing here at the console works fine.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
