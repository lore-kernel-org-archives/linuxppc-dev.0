Message-Id: <s87fa3ee.074@netstal.com>
Date: Fri, 14 Jan 2000 22:31:59 +0100
From: "Niklaus Giger" <n.giger@netstal.com>
To: <grant@lcse.umn.edu>, <linuxppc-embedded@lists.linuxppc.org>
Subject: Antw: Re: Help Sought: 8390-Ethernet Troubles on PowerPC 4xx
	Port
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>> Grant Erickson <grant@lcse.umn.edu> 14.01.00 20:29:50 >>>
>
>Niklaus (and others),>
>...
>The board now at least ARPs through the interface to the NFS server and
>the NFS server responds. However, that's as far as it gets at this point
>(see below). Any ideas? In the interim, I'm going to try experimenting
>with a few more things.
...

Dear Grant,

Are you sure that the ethernet interrupt are correclty handled? It seems to me
that the oak board never answers.

Have you ever serviced correctly a interrupt on the PPC403? 
Interrupt handling on the PPC403 is very different from other PPC-architectures.
If you have HW-debug possiblity through the JTAG, try to break on external interrupt
at address 0x500 and step through the interrupt code to verify that it works correctly.

Other idea: Do you need a byte swapping to set the controller TCP/IP-address/ethernet
adresses?

Regards



Niklaus Giger
Netstal Maschinen AG
CH-8752 Naefels
+41 55 618 64 68
E-Mail: n.giger@netstal.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
