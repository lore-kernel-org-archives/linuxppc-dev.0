Message-ID: <3A8A9EB2.660A7A2D@raleigh.ibm.com>
Date: Wed, 14 Feb 2001 10:05:22 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Wait queue question
Content-Type: multipart/mixed;
 boundary="------------BB506A5925E379F295F2E3E6"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------BB506A5925E379F295F2E3E6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

If I have a wait queue thats I am using to wake up a device driver read
from an interrupt service routine.
If I get three interrupt and three wake_up_interrables, will I need to
execute three sleep_ons to get the wait queue back to the null state, or
is it just back after the first sleep_on?

Chip
--------------BB506A5925E379F295F2E3E6
Content-Type: text/x-vcard; charset=us-ascii;
 name="rcblach.vcf"
Content-Description: Card for Ralph Blach
Content-Disposition: attachment;
 filename="rcblach.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
n:Blach;Ralph
tel;work:919-543-1207
x-mozilla-html:TRUE
url:www.ibm.com
org:IBM MicroElectronics
adr:;;3039 Cornwallis		;RTP;NC;27709;USA
version:2.1
email;internet:rcblach@raleigh.ibm.com
x-mozilla-cpt:;15936
fn:Ralph Blach
end:vcard

--------------BB506A5925E379F295F2E3E6--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
