Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <020c01c25820$89c23880$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 MCC Interrupt priority
Date: Mon, 9 Sep 2002 18:47:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi to everybody,

I'm currently working on a custom board derived from EST8260. We are trying
to implement a device driver of MCC to control the interface with a
synchrounous PCM.
I have noted that when there is an interrupt on SCC1 (or FCCx) the latency
time of MCC interrupt increase. Now I'm really concerned about the
possibility to loose some frame due to an heavy use of such interfaces.

Do anybody knows if there is the possibility to avoid such behaviour (maybe
allowing an interrupt casting with the MCC ISR)?

Many thanks

Gianfranco Morandi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
