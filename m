Message-ID: <3AB8A8BD.4DD4C839@raleigh.ibm.com>
Date: Wed, 21 Mar 2001 08:12:29 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Mark Powell <medp@primagraphics.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling/debugging 405GP and RISCWatch
References: <03ee01c0b206$c4878ea0$3000a8c0@primag>
Content-Type: multipart/mixed;
 boundary="------------6398484B73E12732C4CDD26B"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------6398484B73E12732C4CDD26B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Mark,

Yes, this is sadly true.  There is a bug in gcc which causes this to
happen.
With the Walnut kit, the evaluation copy of the Metaware compiler is
shipped.  You might want to try this.

Chip


Mark Powell wrote:
>
> Hi,
> I'm at the beginning of a project using the 405GP. I have HardHat linux
> (01.03.03 kernel) up and running on a Walnut eval card. That bit is fine.
>
> However, for one very deeply embedded part of the hardware I can't use linux
> (not enough RAM and ROM), I just want a bootstrap to run a single program.
> I'm trying to decide on a debugging strategy and I am considering RISCWatch
> with the JTAG adaptor. I have experimented with RISCWatch using a network
> connection to the Walnut ROM Monitor, but have so far been unable to produce
> an executable with the HardHat/GNU tool chain from which RISCWatch can read
> debugging symbols. The RISCWatch manual says it can read ELF/DWARF files,
> and indeed it seems to download my executable, but gives an error
> "DwarfCompilationUnit: invalid FORM = 0"
>
> I would be grateful for any info on these points...
>
> Is it possible to use RISCWatch with the GNU toolchain?
> Is it possible to use the RISCWatch/JTAG interface as a backend to gdb?
> Any other suggestions for debugging (with no network connection on the
> target)?
> Any pointers to more info.
>
> TIA
> --
> Mark Powell, Senior Software Engineer, Primagraphics Limited
> New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
> Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk
>
--------------6398484B73E12732C4CDD26B
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

--------------6398484B73E12732C4CDD26B--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
