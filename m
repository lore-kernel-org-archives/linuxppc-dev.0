Message-ID: <390F0D6C.1631011D@embeddededge.com>
Date: Tue, 02 May 2000 13:16:28 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Christian Batt <Christian.Batt@sxb.bsf.alcatel.fr>
CC: wd@denx.de, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hard Disk Drive on PCMCIA port
References: <390EEFCC.9A66D452@sxb.bsf.alcatel.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christian Batt wrote:

> We would like to know how it would be feasible to use a
> Hard Disk Drive on such 8xx boards, by using a PCMCIA port.

Yes....I have used the IBM Micro Drive in a PCMCIA adapter.  Given
my limited hardware knowledge, I believe there are enough signals
on the PCMCIA that you could also use an IDE connector to a notebook
or regular IDE/ATA disk drive.  I don't know of anyone that has done
this, as all of the designs I have seen have an external interface
for such devices.

> What are the other possibilities (PCI bridge ...) ?

I can put you in contact with some talented hardware engineers that
have connected damn near everything to a 8xx without using a PCI
bridge.  They use just a little bit of logic in some type of
programmable logic device and out the other side is a bus of choice.
A recent project included a notebook ATA disk drive with DMA....

> Is there allready some support in the current kernels (i.e 2.2.13
> or 2.3.99) for such HDD ?

It's there.  One of my higher priority (out of a zillion) projects
is to get the 8xx PCMCIA integrated into the 2.2.14 and 2.3.99 kernels.
I lost my IBM Micro Drive (had to send it back to the customer), but
I can test with other devices I have.

Right now, you can simply modify the code in m8xx_setup.c to properly
map the PCMCIA and device registers, then add the absolute minimal set
of configuration for IDE/ATA hard disk to the kernel.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
