Message-ID: <3E34B111.6050203@embeddededge.com>
Date: Sun, 26 Jan 2003 23:09:53 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] m8xx_setup.c and PCMCIA
References: <3E30F363.1020501@imc-berlin.de>	<3E3157BF.7060804@embeddededge.com> <15924.24396.105367.383171@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> I'm not really here, I'm on vacation, but anyway...

Me, too :-)


> What it boils down to is that we have little choice (unless you want
> to rewrite the pcmcia layer :) but to make inb/outb etc. do what the
> pcmcia layer is expecting.  That's the reason for the _IO_BASE mapping
> hacks.

I understand that, I was just concerned about why it was needed and the
way it was done in this patch.  The PCMCIA has been working quite well
for many people on the 8xx, so I'm hoping someone that has experience with
that can take a look at these changes and discuss them.

On processors like the 8xx where you have multiple, separate address
spaces that can be the targets of inb/outb, you have to be very careful
how you use the IO_BASE addresses and map those spaces.  Anyone making a
change that uses this raises a big red flag, because it usually "fixes"
one configuration and breaks everything else.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
