Message-Id: <200101051258.GAA21989@lists.linuxppc.org>
Date: Fri, 05 Jan 2001 07:58:24 -0500
From: jingai <jingai@floatingpenguins.com>
To: David Edelsohn <dje@watson.ibm.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re: Status of PCI-PCI bridge on UMAX S900
Reply-To: jingai@floatingpenguins.com
In-Reply-To: <200101042253.RAA27882@mal-ach.watson.ibm.com>
References: <200101042253.RAA27882@mal-ach.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>     Do you only need to look at the immediate parent and not the
> entire ancestor tree?

My guess would be probably, to be thorough.  But I'm no kernel
expert, so anyone else have any comments?

Although (again just guessing), I don't think many (if any) systems
will have more than one PCI controller, or more than one bridge
chip for that matter...

Regards,
Jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
