From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Raymond Waldrop <rwaldrop@sbcglobal.net>,
	Bill Fink <billfink@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: aic7xxx breakage
Date: Sun, 11 Aug 2002 10:26:15 +0200
Message-Id: <20020811082616.1423@192.168.4.1>
In-Reply-To: 
 <20020810084648.A1510@adsl-208-190-252-230.dsl.wchtks.swbell.net>
References: <20020810084648.A1510@adsl-208-190-252-230.dsl.wchtks.swbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ben,
>
>I also encountered this problem on a dual G4 450 (AGP graphics).  On the
>theory that more information is often useful (or at least easily deleted
>from the email queue), I am sending the results of "lspci -vv" as well as
>a couple of dmesg logs.  The last kernel I made that works with the card
>is a 2.4.19-rc1 kernel from the linuxppc_2_4 tree.  This is the kernel
>I was running for the lspci output.  I am also sending dmesg logs from
>this kernel, and from a 2.4.19 kernel built from the linuxppc_2_4_devel
>tree.  If they would be useful, I can also send diffs of any of the PCI
>driver source code files between the two trees.  (I don't know how many
>versions you might have laying around easily fed into diff.)

Ok, can you both try editing arch/ppc/kernel/pci.c, and in
pcibios_init(), replace the call to pcibios_assign_resource()
with a call to pci_assign_unassigned_resources() and tell me
what happens ?
If the resulting kernel boots, please send me the dmesg log and
the lspci -vv output.

Thanks
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
