Message-ID: <D96E2AFA0DF3D211B139009027454948037362FB@helios.gnv.tcc.thomson-csf.com>
From: Christophe.LINDHEIMER@fr.thalesgroup.com
To: callebaut@mailandnews.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: RE :how to do:root filesystem on flash?
Date: Thu, 12 Jun 2003 12:31:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am just working on the same issue ( with romfs ).

Using devfs I must set root equals "/dev/mtdblock/0" and not
"/dev/mtdblock0"...

Regards.

Chris



-----Message d'origine-----
De: Callebaut Benoit [mailto:callebaut@mailandnews.com]
Date: jeudi 12 juin 2003 11:33
À: linuxppc-embedded mailing list
Objet: RE :how to do:root filesystem on flash?



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
