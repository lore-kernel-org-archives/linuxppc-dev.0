Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <75DF04AC5ED4D511A9810090273CB4163F5DDD@rokonet-e.rokonet.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Access u-boot environment variables from Linux
Date: Sun, 13 Jul 2003 17:38:55 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I use the SELF from Denx (with busybox 0.60.1).

I have configure the config.mk.TQM860L_FEC file with: HAVE_FLASH_ENV = yes.
Also, I have copied the /lib/modules folder from the ELDK so the modprobe
wont complain.

Trying to do: printenv, flash_info or any command result in :

modprobe: modprobe: Can't locate module char-major-60
/dev/flasha: No such device

I can see all /dev/flasha and others.

The kernel is the default TQM860L_FEC  from the ELDK (not from SELF, but
should be the same).

Please advise...

Thank you,
Eli Brin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
