Message-ID: <3AEDABAF.38584DBA@raleigh.ibm.com>
Date: Mon, 30 Apr 2001 14:15:11 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>,
	Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ppc little-endian port
References: <200104282316.f3SNG7D365341@saturn.cs.uml.edu> <3AED9DB8.7B15F60D@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------49E31618800B1C0935F8DB24"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------49E31618800B1C0935F8DB24
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan Malek wrote:
>

> > Lots of PowerPC processors run in little-endian mode today.
>
Dan,

All 40x processor models support propper little endian. And the 4xx do
NOT get Alignment exceptions for
missaligned data.  So no performance penalty.  On the 4xx it is NOT
getting harder to use little endian,
Its as  easy as just setting the bits.


Chip

> Lots?  Maybe a few.  Since the first days of PowerPC I have only
> seen one ill-fated attempt.  Every time I'm part of a PPC silicon
> design discussion the question is always raised whether it is
> worth wasting silicon trying to support it.
>
> It's getting harder to use little endian on PowerPC.  The 7450 has
> only a big endian bus, with some weird lane swapping internally.
> Misaligned little endian accesses still cause processor exceptions,
> and the 7450 states it doesn't support it at all (some contradiction
> here), so you are always at a performance disadvantage when using
> it.  Besides, the bytes are all backward from the normal order of
> the world and you end up spending cycles swapping them, anyway :-).
--------------49E31618800B1C0935F8DB24
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

--------------49E31618800B1C0935F8DB24--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
