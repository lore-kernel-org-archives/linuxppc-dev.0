Message-ID: <38b3effd38fb6775@amyris.wanadoo.fr> (added by amyris.wanadoo.fr)
Date: Wed, 23 Feb 2000 15:29:06 +0100
Subject: OF doesn't know my hard drive
From: "Florent" <flobo@iname.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone ever booted something or even achieved a "dir" command on an IDE
disk located on the second IDE bus of a blue G3 (and perhaps any newworld
machine) ?

Here are the locations of the ide devices in the OF three :
/pci/@d/mac-io/ata3/disk@0 (cd)
/pci/@d/mac-io/ata3/disk@1 (zip)

/pci/@d/pci-ata/ata-4/disk@0 (hd or ultra0)
/pci/@d/pci-ata/ata-4/disk@1 (ultra1)

What's wrong with the second IDE bus ? (/pci/@d/mac-io/ata3)
Why is it not located next to the first on the OF three ?
It seems it lacks appropriate methods to handle hard drives correctly...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
