Date: Thu, 4 Feb 1999 16:51:43 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Gerd Knorr <kraxel@goldbach.in-berlin.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: I/O port access ???
In-Reply-To: <Pine.LNX.4.03.9902042132120.17258-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96.990204165034.28537A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What I'm looking at doing in the next weeks is unifying the IO bases.
We'd remap the IO (as we do on prep now) for all the arch's so that we
only need one set of io base values.

}> Is there some way to access the I/O ports, for example the VGA registers
}> of some graphics board (assuming the I/O ports are enabled in the PCI
}> config space) on ppc boxes?  How can I do that with Linux?  From kernel
}> space?  From user space?
}
}You have to mmap() /dev/mem. Which address depends on the type of PPC box.
}You can find the correct addres in <asm/io.h> (*_ISA_IO_BASE).


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
