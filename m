Message-ID: <3AC86B13.7FDCC53B@raleigh.ibm.com>
Date: Mon, 02 Apr 2001 08:05:39 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Why does the linux kernel?
Content-Type: multipart/mixed;
 boundary="------------86843B62CC4E3667168AC860"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------86843B62CC4E3667168AC860
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

A few days ago I posted an append to this forum asking to what error a
segmentation fault refered.
I finally discovered my problem in my kernel.  I was marking all user
pages as user/read/write.
Why does the linux kernel care if some pages are marked read only and
others are marked read/write.

Thanks in advance.

Chip
--------------86843B62CC4E3667168AC860
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

--------------86843B62CC4E3667168AC860--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
