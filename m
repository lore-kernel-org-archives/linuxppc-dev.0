Message-ID: <39F5B85C.2B6ED9DB@raleigh.ibm.com>
Date: Tue, 24 Oct 2000 12:27:08 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: pointers to ld.so.1
References: <67505026E29DD311A9AA00508B7315F350A56D@EXCHANGE>
Content-Type: multipart/mixed;
 boundary="------------569033BEC1F311A1D98F4AE3"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------569033BEC1F311A1D98F4AE3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I am working the Monta Vista port of linux to the IBM405gp
and I am trying to put in a ramdisk.  What links do i need in a ramdisk
so that
the libraries can be found.  Right now, I get the message

initKernel panic: Attempted to kill init!
: error in loading shared libraries: libdl.so.2:Rebooting in 180
seconds.. cannot open shared object file: No such file or directory

Yet libdl.so.2 and all the links are the the /lib directory.

Thanks

Chip
--------------569033BEC1F311A1D98F4AE3
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

--------------569033BEC1F311A1D98F4AE3--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
