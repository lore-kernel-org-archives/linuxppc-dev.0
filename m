Date: Sat, 14 Jul 2001 19:34:24 +0200
From: Olaf Hering <olh@suse.de>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: More on booting 43P-140
Message-ID: <20010714193424.A23530@suse.de>
References: <36062.192.168.1.2.995129406.squirrel@fridge.bcc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36062.192.168.1.2.995129406.squirrel@fridge.bcc.co.uk>; from leigh@solinno.co.uk on Sat, Jul 14, 2001 at 05:50:06PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jul 14, Leigh Brown wrote:

>
> Hi all,
>
> After an embarrasing hour when I couldn't work out why the root fs disk
> wasn't being recognised for my kernels but was for the one I downloaded,
> I have finally made it into the install program for SuSE 7.1 and Debian
> woody.  However, both have the same problem - they say I don't have any
> disks!  This is weird because in both installers I can bring up a shell
> and manually create and mount an ext2 partition on hdisk1 (/dev/sdb).


Do you have devfs active in your .config? If yes, boot with "nodevfs" or
devfs=off.

cat /proc/partitions should show /dev/sdaX and notsomething different.

Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
