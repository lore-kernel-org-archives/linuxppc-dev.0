Date: Tue, 1 Feb 2000 23:04:41 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: find the OF boot-device
Message-ID: <20000201230441.B9215@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <20000201225122.B7845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000201225122.B7845@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 01, Olaf Hering wrote:

> we need an app to tell us the OF device path to a file. I'm working on
> that but I have a strange problem with a G4 400 AGP:
>
> There are 3 entries /proc/device-tree/pci and all of them have the same
> inode number:

It is fixed with the latest Kernel from Benh.


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
