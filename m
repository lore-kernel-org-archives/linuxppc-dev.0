Message-ID: <36470.192.168.1.2.995137614.squirrel@fridge.bcc.co.uk>
Date: Sat, 14 Jul 2001 20:06:54 +0100 (BST)
Subject: Re: More on booting 43P-140
From: "Leigh Brown" <leigh@solinno.co.uk>
To: olh@suse.de
In-Reply-To: <20010714193424.A23530@suse.de>
References: <20010714193424.A23530@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Reply-To: leigh@solinno.co.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> 7.1 and Debian woody.  However, both have the same problem - they say
>> I don't have any disks!  This is weird because in both installers I
>> can bring up a shell and manually create and mount an ext2 partition
>> on hdisk1 (/dev/sdb).
>
> Do you have devfs active in your .config? If yes, boot with "nodevfs"
> or devfs=off.
>
> cat /proc/partitions should show /dev/sdaX and notsomething different.

Thanks.  I rebuilt the kernel without devfs support and its working now.
Hopefully, that was the last obstacle to a successful install.

Cheers,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
