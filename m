Message-ID: <3B5EFE8F.CFB340A4@raleigh.ibm.com>
Date: Wed, 25 Jul 2001 13:14:55 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>,
	Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: New Linux PowerPC development
References: <A109131318C4D1119AC20060088DECE35732DF@mail.adaptivemicro.com> <3B5DAFC9.414B4788@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------4D8291F37150E29303FFD1BD"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------4D8291F37150E29303FFD1BD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan,

You forgot to mention the internal full duplex PLB on the 405.  ON the
405GP,
the Ethernet, PCI, EBC and memory are connected with a full duplex PLB
64 bit bus.

Its not a performance slouch either.

Chip
Dan Malek wrote:
>
> Cindy Peters wrote:
>
> > The MPC823, however, does not have an IDE or PCI interface for a hard disk.
>
> Sure it does.  Just use the PCMCIA.
>
> > We feel we would have to design an interface into an FPGA.
>
> This is also a solution many people use.  Lots less expensive and
> less complex than a PCI adapter.
>
> > .... It doesn't
> > support 100BaseT either.
>
> So, the 832 loses here :-).
>
> > ..... We are also looking at using either the
> > MPC8260/MPC8265 or the IBM 405GP.
>
> Wow.  The 823, 405, 8260 span a huge range in performance and features
> (and price).  You need to consider some other requirements to make this
> decision.  If the 823 would be enough performance, you can step up to
> the 860(D/T/P) and get more performance.  Depending upon the application,
> the 860P can be higher performance than the 405 because it will offload
> the integrated peripherals to the CPM.  The highest performance of the
> bunch is the 82xx, which also includes hardware floating point, if that
> is important.
>
> > .... I would like some feedback from people that have experience in using
> > these processors with Linux and what recommendations they have.
>
> I've used them all, and they all have advantages and disadvantages.
> You didn't list many requirements that would clearly show one is better
> suited for your application.  Based on what you said, and past experience
> with the 823, I would choose something from the 855/860 family.
>
>         -- Dan
>
--------------4D8291F37150E29303FFD1BD
Content-Type: text/x-vcard; charset=us-ascii;
 name="rcblach.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Ralph Blach
Content-Disposition: attachment;
 filename="rcblach.vcf"

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

--------------4D8291F37150E29303FFD1BD--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
