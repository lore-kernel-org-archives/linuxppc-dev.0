Message-ID: <3AC08CA8.D15B04AF@raleigh.ibm.com>
Date: Tue, 27 Mar 2001 07:50:48 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Zehetbauer Thomas <TZ@link.topcall.co.at>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: booting HardHat on IBM 405GP
References: <41EA756DBC9FD0118CFC0020AFDB5C5A188D91@tcint1ntsrv>
Content-Type: multipart/mixed;
 boundary="------------F17B431FC3CD5DB9ED3C91B7"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------F17B431FC3CD5DB9ED3C91B7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Zehetbauer,

Hi,  This is a function call to sa, and if you look at the address of sa
(the starting address) I'll bet it absoulte 0.  So, what happens is you
get a jump to zero.

Heres the boot process.
1)move the ramdisk to upper memory.
2)uncompress the kernel image starting a real 0.
3)Jump to 0.

Chip Blach

Zehetbauer Thomas wrote:
>
> Hi!
>
> My company is going to develop an embedded solution based on a IBM 406GP
> processor.
> We are in early development right now and I am trying to boot linux on a
> > IBM 25 EB 405 P4 WIN WAL 00
> evaluation kit (this is the information on the bill of delivery).
>
> Attempting to debug I've found linux/arch/ppc/boot/tree/main.c:start to
> be the first function executed.
> At the very last step this function calls
> >    (*(void (*)())sa)(&board_info,
> >                      initrd_start,
> >                      initrd_start + initrd_size,
> >                      cmdline,
> >                      cmdline + strlen(cmdline));
> and I can't find where execution goes on.
>
> Any help is greatly appreciated.
>
> TIA
> Tom
>
> PS: Does someone know how to determine the board's revision number?
>
--------------F17B431FC3CD5DB9ED3C91B7
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

--------------F17B431FC3CD5DB9ED3C91B7--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
