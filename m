Date: Thu, 21 Jan 1999 00:00:37 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Ranjit Deshpande <ranjitd@sco.COM>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI-PCI bridges
In-Reply-To: <Pine.SCO.3.96.990120111039.13973A-100000@mammoth.sco.com>
Message-ID: <Pine.LNX.3.96.990120235850.29068A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


They appear to be.  I'm trying them out now.

}1. Are the changes I made valid ? I don't claim to be an expert on PPC
}   hardware. And this was my first hack of the Linux kernel on any
}   architecture.

I'm just speaking for myself, it was an oversight.  Paul may have left it
out for a reason, though.

}2. Is there a reason for PCI-PCI bridges not being supported by the newer  
}   kernels ?

It shouldn't need any changes.  Does access to the other registers work?

}3. Why is the tulip code not reading the EEROM ? I'm using the standard
}   drivers/net/tulip.c. Does it require any PMAC specific changes ?


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
