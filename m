Message-ID: <3AE5A354.9A82E5DA@raleigh.ibm.com>
Date: Tue, 24 Apr 2001 12:01:24 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: pte entries for the 440
Content-Type: multipart/mixed;
 boundary="------------12CCC12350BE0470C8CEF1BC"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------12CCC12350BE0470C8CEF1BC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I am starting a port of linux to the IBM440 processor.  The 440 has an
36 bit address space.  Reading the kernel sources, I see two options for
the page tables.
1)One, make it a structure with the permissions being in the second
word.
2)Make it a long long.

Does anybody have any ideas on this?

Thanks

Chip
--------------12CCC12350BE0470C8CEF1BC
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

--------------12CCC12350BE0470C8CEF1BC--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
