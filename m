MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Console not appearing with iBook and 2.4.8-pre8
Date: Fri, 10 Aug 2001 08:55:08 +0200
Message-ID: <2C5637A6A7CE844EA3C0A94565479F520B470B@dest-as20-002.int.bauer-partner.com>
From: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This morning I build a fresh kernel from the bk-repository
on my (old) iBook. I did a

	make oldconfig depend vmlinux modules modules_install

When booting the last message is the "prom_init" message
in the yaboot screen. After that no console appears.
Everything else seem fine. I can blindly login as
root and reboot the system. As I remember, this started
a few days ago, I think with 2.4.8-pre6.

(Now, while writing about this, I think tonight Ill do
 a "make clean" and try again. )

Greetings,
  _ _
 /   \         Bauer & Partner AG
|     |  The Business and Technology Group
`     ´
 `---´    Klaus Halfmann,  Dipl. Inform.
Tel. +49(0)69-24779-0 Fax +49(0)69-24779-444
         klaus.halfmann@bauer-partner.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
