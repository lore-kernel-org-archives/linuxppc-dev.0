Message-Id: <200101251959.OAA27790@mal-ach.watson.ibm.com>
To: Dan Malek <dan@mvista.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>, mgreer@mvista.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC 
In-Reply-To: Message from Dan Malek <dan@mvista.com>
   of "Thu, 25 Jan 2001 14:47:43 EST." <3A7082DF.CD7E8B61@mvista.com>
Date: Thu, 25 Jan 2001 14:59:06 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Dan Malek writes:

Dan> Heh....64Gbyte is nothing, just a few more bits beyond 32....you
Dan> don't need 64-bits for this.  In fact, I had a revelation last
Dan> night where I thought we could even do this quite transparently
Dan> on PowerPCs with VSIDs or even context registers, anything that
Dan> implictly gives us a few more bits of virtual address.  Later
Dan> on that.....

	Yes, that is the exact purpose of the PowerPC addressing model.
While one user context is limited to 32-bit addresses, the system can map
a larger physical address range into the process's virtual address space.
The process even could handle this with OS cooperation using overlays.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
