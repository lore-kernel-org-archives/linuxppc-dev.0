Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "AUBERT Cedric" <cedric_aubert@softhome.net>
To: "LinuxPPC Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: U-Boot question
Date: Tue, 11 Feb 2003 09:03:34 +0100
Message-ID: <NEEAIENMOLHNBKKFKIDMMEEICAAA.cedric_aubert@softhome.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am in the state "while(learning){ .... }" of the U-Boot Porting Guide in
the README file.

And there is a point that I don't understand.

The option CFG_SDRAM_BASE is the physical start address of SDRAM.

Okay, I understand that. But it's written _Must_ be 0 here.

How can I do if my SDRAM ( on a MPC860 Board ) start at 04000000 ???

Thanks a lot

PS : Sorry to don't post to the U-Boot mailing list but I have a failure
notice each time
I try to post on it. (550-Envelope sender verification failed)

---
AUBERT Cedric
SDEL Controle Commande
Service R&D
rue Nungesser & Coli
44860 St Aignan de Grand Lieu

Tel : +33 (0)2 40 84 50 00
Poste : 5109
Fax : +33 (0)2 40 84 51 10

E-mail : cedric_aubert@softhome.net
Web : http://www.controle-commande.sdel.fr

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
