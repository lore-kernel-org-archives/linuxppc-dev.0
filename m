Date: Sun, 9 Jan 2000 14:29:00 +0100
From: Olaf Hering <olh@suse.de>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: write into OF tree like nvsetenv
Message-ID: <20000109142900.A17353@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <20000108171526.B8126@suse.de> <v04220818b49df84590b1@[192.168.0.1]> <38785B2C.7807E8FD@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38785B2C.7807E8FD@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 09, Martin Costabel wrote:

> 
> I am somewhat surprised that nobody mentions the "Christmas Present"
> boot script by BenH
> (http://lists.linuxppc.org/listarcs/linuxppc-dev/199912/msg00191.html).
> I installed this on several iMac DVs, and it works great. Now you don't
> have to fiddle with OF any more, and if you put a timeout into
> yaboot.conf, booting into Linux is completely automatic.

Yes, this script is just great.

> You only have to enter OF once, type
> setenv boot-device hd:10,yabootloader.script

I want exactly this automatic. This works fine on the current IDE Macs,
but with a B&W Scsi Mac a "typical" User has lost.
The path on my Mac is something like

/pci/pci-bridge/ADPT,2940U2B/@6:7,blah

Too complex.


Gruss Olaf

-- 
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
