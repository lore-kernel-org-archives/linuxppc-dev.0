Message-Id: <9911111547.AA37258@marc.watson.ibm.com>
To: "Florent" <flobo@iname.com>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Re : Newworld OF boot 
In-Reply-To: Message from "Florent" <flobo@iname.com>
   of "Thu, 11 Nov 1999 05:48:24 +0100." <382a4a48382aafdc@villosa.wanadoo.fr>.(added.by.villosa.wanadoo.fr)
Date: Thu, 11 Nov 1999 10:47:17 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	What is the requirement for the OF booter reading the kernel from
a filesystem?  AIX piggybacks the kernel on the OF booter itself.  The
entire file is loaded by OF and then the booter decompresses and/or copies
the kernel to the location from which it takes control and relocates
itself to its final destination.  This may not be perfect, but it avoids
the problems of teaching the OF booter how to read partions and
filesystems. 

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
