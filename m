Date: Thu, 12 Jun 2003 05:33:04 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE :how to do:root filesystem on flash?
Message-ID: <3EEDFF92@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I,
1 : Create a cramfs filesystem with the right endianess from your nfs
filesystem using mkcramfs.
Burn it into the flash( at the start of the flash).

2 : In your kernel config set the "root=" option to : "/dev/mtdblock0"
Enable Flash MTDBlock support and the right options like CFI,...
Set up the start of the flash and its length
Enable Cramfs in filesystem
Disable NFS as root filesystem.

Rebuild your kernel and flash it.
Reboot the board en enjoy.

PS : This question was already a 100 times answered. Search in the mailing
list before asking such a question.
Or maybe a better idea : One may build a FAQ or a list of Howtos on such
common questions.

Benoit Callebaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
