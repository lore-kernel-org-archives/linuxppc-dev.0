Message-ID: <D96E2AFA0DF3D211B13900902745494803736331@helios.gnv.tcc.thomson-csf.com>
From: Christophe.LINDHEIMER@fr.thalesgroup.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: [Linux][MTD] Is it possible to use MTD without CFI ?
Date: Wed, 18 Jun 2003 15:13:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I would like to use MTD to put my romfs but without using CFI.
I am using XIP and I can't accept the flash to go into strange config
state...
So I thought about selecting MTD & "Driver for non CFI Flash".
But I don't undersatnd where I can give the @ of my flash...
In fact the menu where to go give the @ only appears when selecting CFI...

Thanks

Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
