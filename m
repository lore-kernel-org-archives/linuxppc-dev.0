Message-ID: <3ADEE023.7BCFCD29@raleigh.ibm.com>
Date: Thu, 19 Apr 2001 08:54:59 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: iweiny@pacbell.net
Cc: linuxemb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Walnut IDE support
References: <200104182216.PAA02532@batcave2.batcave>
Content-Type: multipart/mixed;
 boundary="------------61D6C1B9F51C2B71C5E570CB"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------61D6C1B9F51C2B71C5E570CB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ira,

You might want to try the latest MontaVista kernel.  I had to use
hda=swapdata to get it to function.

Chip

iweiny@pacbell.net wrote:
>
> I am trying to get a Promise Ultra66 IDE card running on the Walnut board.
> The kernel recognizes the card but gives the following errors.
>
> PDC20262: IDE controller on PCI bus 00 dev 08
> PDC20262: device not capable of full native PCI mode
> PDC20262: device disabled (BIOS)
>
> Is there a configuration setting or kernel param I am missing?
>
> Thanks,
> Ira Weiny
>
--------------61D6C1B9F51C2B71C5E570CB
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

--------------61D6C1B9F51C2B71C5E570CB--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
