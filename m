From: Simon Winwood <sjw@cse.unsw.edu.au>
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 27 Nov 2001 10:30:42 +1100
Subject: More walnut boottime "fun"
Message-ID: <20011127103042.A11612@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi,

	Apart from NFS not working, it looks like the bootloader is
clobbering itself when the image is reasonably large (> 1M?).

	This happens when it relocates itself (the initrd or whatever
overwrites the relocation code).

	Has anyone fixed this, or should I keep going ;)

	Simon

p.s. this is only an issue where the dest address < the load address, as
on walnut and friends

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
