Date: Tue, 22 Jun 1999 03:26:05 -0400 (EDT)
From: satadru pramanik <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: R5 X setup on B/W G3; OF Setup; USB mouse support
Message-ID: <Pine.LNX.4.10.9906220308450.17871-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

After extensively browsing the list archives, and various man pages, i
have been unable to come to an understanding as to how I should change the
resolution in X unless I reboot into MacOS, change resolutions, and reboot
back into Linux.   Is this true?   fbset refuses to change resolutions
at the console.   



Secondly, I'm using the 2.2.10 kernel sources posted earlier with the USB
support, and they work fantastically, letting me use the USB keyboard on
the B/W G3, but the mouse refuses to work inside X...   How do I configure
X to use the USB mouse, instead of having to hook up a ADB mouse?

Another USB issue: going to single user mode unloads USB support, perhaps
not the best of options if one plans to use a USB keyboard at the console,
I suppose.  

Finally, I have been using OF to boot a 7600/132 successfully all the way
through to 2.2.7.   I'm hearing that the MacOS boot mechanism through
BootX may cause certain problems, such as the total lack of sound I have
right now.  I understand that certain coff headers aren't being
generated correctly for the OF 3.0+ revisions, is this an issue if I have
already installed Linux on the internal IDE hard disk?   I have messed
around in OF on the B/W G3 just like I did on the 7600, and as far as I
can tell, a boot-device setting for the 6th partition on the internal IDE
disk should be this (looking at the system-disk control panel output):
/pci@80000000/pci-bridge@d/pci-ata@1/ata-4@0/@0:4

just like the 7600 has a boot-device entry of this:
/bandit@F20000000/ADPT,2940U2W@D/disk@0:0


I don't get a claim failed, just some message about the LOAD being too
small or something. (no serial port, no serial console logging, sigh.)

But it just doesn't work.  I've already run quik to set up the
bootloaders. Does anybody know how to get OF booting working on the B/W
G3s?

Any help on these issues would be appreciated.  Then I can go back to
installing LinuxPPC 5.0 in a NFS boot version for my network with
Mac-On-Linux to get my VTs and X while running Quark.
<silly grin>

sat


- --=
satadru pramanik `satadru@umich.edu' www.umich.edu/~satadru
MIS, Student Publications
"I'm old enough to be living in the future I was warned about."
  - Myron Krueger
=--

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBN286mUwK0JxvsXXVEQKtFgCg02NzIqRnSySJTy5GY11ZcVE3vkgAoMWT
MgPyhUrj2VcYkvXlWMwBf/bl
=Nt5/
-----END PGP SIGNATURE-----


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
