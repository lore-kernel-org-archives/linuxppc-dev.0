Message-ID: <3DB0D2E7.57F51578@koffie.nl>
Date: Sat, 19 Oct 2002 05:35:02 +0200
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Xavier Grave <grave@ipno.in2p3.fr>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: install with Debian CD ok, but can't boot any kernel
References: <200210181610.SAA19888@ipnmail.in2p3.fr> <20021018183506.17444@192.168.4.1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> You may have to type the whole path to the ATA/66 disk in
> OF instead of "hd", which is something like
> "/pci@f2000000/mac-io/ata-4" or maybe with an additional
> pci-bridge in between. To see the actual nodes in OF, type
> "dev /" then "ls". To see the "shortcuts" (aliases), do
> "dev /aliases" then ".properties"

The alias for the ata-4 disks are ultra2 and ultra3; the aliases
for the ata-6 disks are ultra0 and ultra1 (hd is the same as ultra0).

So you want ultra2.


Cheers,

Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
