Message-ID: <3AB65B72.F77A0760@raleigh.ibm.com>
Date: Mon, 19 Mar 2001 14:18:10 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: Ralph Blach <rblach@intrex.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: es1371.o sound module on a IBM 405 walnut platform
References: <3AB4E3BA.AF71AFE6@intrex.net> <3AB52248.D2411FF2@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------6B9A86563C4DC368FA630183"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------6B9A86563C4DC368FA630183
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan,

Well it does.  And I recomend a new kernel interface, and Dan, I KNOW
YOU WILL not like THE VERY IDEA,
by here it is.

I beleive that a kmalloc_little_endian and a kmalloc_nocache should be
added to the port.
The ability to allocate a little endian memory would by defaut handle
conversion in a seamless and quick manner.
copy_from_user and copy_to_use would then do the bit to little endian
conversions.

By the same token, an interface to allocate noncached memory would be
spiffy.  I would also assist in the porting of device drivers that need
lots of little non cached spaces like scsi and USB drivers.



Chip


The 405gp has the ability

Dan Malek wrote:
>
> Ralph Blach wrote:
>
> > ... Will this driver have to be made
> > endian aware?
>
> Probably.  I've had a couple of the ES boards running in Walnut, I
> don't remember the details now.  The board was confiscated for
> other more urgent work, so someday I hope to get back to it.
>
>         -- Dan
>
--------------6B9A86563C4DC368FA630183
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

--------------6B9A86563C4DC368FA630183--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
