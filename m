From: "Sanjay Kumar" <skumar@giga-stream.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Registering ATM devices.
Date: Fri, 13 Jun 2003 08:39:23 +0200
MIME-Version: 1.0
Message-ID: <FKEJLMJFECLAHOKCGJFPMEOACAAA.skumar@giga-stream.de>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

I have MPC8266 having connected two UTOPIA II interface on FCC1 and FCC2.
UTOPIA II interface connected to FCC1 has 16 PHY devices connected to it
and UTOPIA II interface connected to FCC2 has 2 PHY devices connected to
it.
                    while registering the atm devices via
atm_device_register() function should I register two atm devices, one for
each UTOPIA II interface conncetd to FCC1 and FCC2 or 18 atm devices for
each PHY devices connected on both UTOPIA II interface.Total number of PHY
devices on both UTOPIA II interface is 18.

Any suggestion will be helpfull to me.

with regards,
sanjay

 ==============================================================
 Sanjay Kumar                        skumar@giga-stream.de
 GIGA-STREAM UMTS Technologies GmbH  Tel: +49 (07243) 94976-119
 Im Ermlisgrund 8                    Fax: +49 (07243) 94976-100
 76337 Waldbronn
 ==============================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
