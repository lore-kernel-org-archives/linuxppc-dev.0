Message-ID: <001701c01e61$958ed240$0a00010a@paoloweb>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: rebooting with the FADS
Date: Thu, 14 Sep 2000 17:36:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


on my FADS, i see that it is not possible to reboot from software: you must
press the reset buttons to do this.

But, i sometimes have reboot problems. I see BCSRx registers have strange
values and the bootrom seems to stop downloading the kernel randomly. This
of because of erroneous values into memory configuration registers.

how can i make a soft-reboot?
how can i resolve this problem with strange register-values on reboot?

=-> MAY THE PINGUIN B WITH U! <-=

Best regards,
Paolo Scaffardi (arsenio@tin.it - pscaffardi@supereva.it)
AIRVENT SAM s.p.a. - RIMINI (ITALY)
Tel. 0541 383294 - Fax 0541 387086


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
