Message-ID: <003301c465ad$04db1230$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
	"Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.60.0407081035280.32470@localhost.localdomain>
Subject: Re: what is the status of devfs?
Date: Fri, 9 Jul 2004 08:05:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>    probably should send this to the main kernel list, but in playing
> around, i noticed that DEVFS_FS is labelled as both OBSOLETE and NEW,
> but in the Kconfig file, it depends on EXPERIMENTAL.
>
>    it seems a bit inconsistent for anything to be simultaneously
> EXPERIMENTAL, NEW and OBSOLETE, no?
>

I found the following in udev-FAQ:

Q: Why was devfs marked OBSOLETE if udev is not finished yet?
A: To quote Al Viro (Linux VFS kernel maintainer):
	- it was determined that the same thing could be done in userspace
	- devfs had been shoved into the tree in hope that its quality will
	  catch up
	- devfs was found to have fixable and unfixable bugs
	- the former had stayed around for many months with maintainer
	  claiming that everything works fine
	- the latter had stayed, period.
	- the devfs maintainer/author disappeared and stoped maintaining
	  the code.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
