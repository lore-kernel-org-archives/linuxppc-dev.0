Message-ID: <00df01c2e90a$85fc3b80$af85efcb@qhavm>
From: "Q-ha Park" <qhpark@jchyun.com>
To: "Q-ha Park" <qhpark@jchyun.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
References: <000d01c2e6c2$621e1de0$af85efcb@qhavm>
Subject: Re: kernel stops after the msg, "Now booting the kernel"
Date: Thu, 13 Mar 2003 11:44:51 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> I've been using the kernel 2.4.17 for redwood5 from montavista. recently, I tried to use the 2.4.21-pre5 kernel, but it stops right after the msg: "Now booting the kernel".
> ----------------
<snip>
> Linux/PPC load: console=ttyS0,115200
> Uncompressing Linux...done.
> Now booting the kerne
> <stopped>
>
works with the default config file in arch/ppc/configs/redwood5_defconfig.
okay, that was stupid. i'm going to go out and commit a suicide now.

BTW, FYI, to get the nfs root mount to work, i had to append the cmdline paramters like:
"root=nfs rw ip=auto"

at first, i didn't add that since netroot_string is declared in misc-embedded.c and the old kernel i had mounted the root filesystem without the 'root=' parm.

well, that was a change.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
