Message-ID: <3A76F163.406CBFDB@raleigh.ibm.com>
Date: Tue, 30 Jan 2001 11:52:51 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: which errno should I use
Content-Type: multipart/mixed;
 boundary="------------95929805FCB9CA33FD426DCC"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------95929805FCB9CA33FD426DCC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I am writing a character device driver.  I want this device driver to
return an error if the user request less than say 1024 byte of data.
What errno should I use?  Is it legal to return an error if not enouth
bytes are requested?

Thanks

Chip
--------------95929805FCB9CA33FD426DCC
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

--------------95929805FCB9CA33FD426DCC--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
