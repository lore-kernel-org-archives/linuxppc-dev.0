Message-ID: <3A894F05.AAFB7427@raleigh.ibm.com>
Date: Tue, 13 Feb 2001 10:13:09 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: WaitQueues.
Content-Type: multipart/mixed;
 boundary="------------1891E666C195432E7BDC8DD2"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------1891E666C195432E7BDC8DD2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Is there anyway to contionally initialize a wait queue. I want to test a
wait queue to see if has been initialized not initialize it.  If not,
how do I serialize an access to a set location so that I can atomically
test and increment that location?

Thanks

Chip
--------------1891E666C195432E7BDC8DD2
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

--------------1891E666C195432E7BDC8DD2--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
