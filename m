Message-ID: <3A80158B.FEA05CAF@raleigh.ibm.com>
Date: Tue, 06 Feb 2001 10:17:31 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: New device Class
Content-Type: multipart/mixed;
 boundary="------------5F16E984FAB085BEF6979CCC"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5F16E984FAB085BEF6979CCC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I need to create a new device class so that I can have a new (Very
expermental and temporary) device major.  ( How is this done?  Can I
copy the misc device class initialization and just change the major?

The device will need up to 64 minors.

What is the correct way to do this?

Thanks

Chip
--------------5F16E984FAB085BEF6979CCC
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

--------------5F16E984FAB085BEF6979CCC--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
