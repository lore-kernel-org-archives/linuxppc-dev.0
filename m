Date: Thu, 2 Nov 2000 10:01:25 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Todd Inglett <tinglett@vnet.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Yet another RS6k whipped!
In-Reply-To: <3A006299.73525FEE@vnet.ibm.com>
Message-ID: <Pine.LNX.4.10.10011020958420.19218-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> checking command line arguments...
>         unknown option 'console=ttyS0,9600'!done
> checkEXT2-fs warning: checktime reached, running e2fsck is recommended
> ing for NFS root filesystem...no
> trying to remount root filesystem read write... done
> checking for writeable /tmp... yes
> couldn't open /dev/tty4 for syslog -- still using /tmp/syslog
> running install...
> failed to open /dev/tty1failed.
>
> I can't recover from this.

Something's broken with serial support (no serial console support compiled
in?). And fron the tty1/tty4 error I'd guess there's no
framebuffer/VGA/other console device registered either.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
