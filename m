Message-ID: <20000429175402.10460.qmail@web1605.mail.yahoo.com>
Date: Sat, 29 Apr 2000 10:54:02 -0700 (PDT)
From: Jens Tingleff <jens_tingleff@yahoo.com>
Subject: Development kernel (2.3.99-pre6) config problem (BLK_DEV_IDE and PMAC_PBOOK)
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy


[This is just FYI, I'm not on the list]

Just a note to say that if one prunes the options recklessly, there is
a conflict between having CONFIG_PMAC_PBOOK on and CONFIG_BLK_DEV_IDE
off. (The first is activated by PowerBook power saving option, the
second under IDE devices in general; I had IDE driver as module.)

The last function of drivers/macintosh/mediabay.c fails teh compile
because it uses a structure field which is only defined if
CONFIG_BLK_DEV_IDE is defined.

This is for kernel 2.3.99-pre6 picked off linuxcare.com.au this
morning.

Cheers

	Jens



=====
Key ID 0x09723C12, j.tingleff@ieee.org/jens_tingleff@yahoo.com
       Analogue filtering / HIPERLAN / MkLinux / odds and ends
http://www.imaginet.fr/~jensting/             +44 1223 211 585
 "You can't fight in here! This is the War Room!" 'Dr Strangelove'


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
