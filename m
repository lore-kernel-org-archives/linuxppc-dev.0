Message-ID: <38AD47D7.C0906984@ibk.liu.se>
Date: Fri, 18 Feb 2000 14:23:35 +0100
From: Mats Soderstrom <mats@ibk.liu.se>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: paulus@linuxcare.com
Subject: Re: 2.3.45 on B&W G3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>I have fixed the problem that was causing B&W G3s (and other machines with
>a PCI-to-PCI bridge) to hang early on in the boot process with the devel
>kernels.  The problem was that the pcibios_read/write_config_word calls in
>the init_p2pbridge function weren't working (they don't work until the PCI
>buses have been scanned now).  I changed those calls to ppc_md.pcibios_*
>and it gets a lot further now.
>
>My linux-pmac-devel rsync tree has this fix but is still at 2.3.45 for now.

I just rsync'ed the pmac-devel source and I still get the hang at "booting... "
when I try this kernel. I have a beige G3, 300MHz and use BootX 1.2b3

/Mats Soderstrom


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
