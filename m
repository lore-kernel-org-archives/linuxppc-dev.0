Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: MPC5200 PCI questions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 16 Jun 2004 11:30:07 +0200
Message-ID: <42A622EB18325843894BB8E1040E3DF502274E@sinaexchf>
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.
Is it possible, with the present version of BestComm, to use DMA for IDE and PCI at the same time?
As is not possible to use IDE DMA and the integrated FEC at this moment, I'm thinking of using the integrated ATA controller in the MPC5200 with DMA for an IDE disk and the PCI controller to interface to a PCI to ethernet transceiver in a custom board. Is this possible? Any recommended transceiver to use with linux and the MPC5200?.
Also, I would like to know if there is a known to work PCI ethernet card (10/100 if possible) for use with the Lite5200 kit, supported by linux.
Thanks in advance.

Iñigo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
