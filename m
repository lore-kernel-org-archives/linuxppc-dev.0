Date: Sun, 12 Sep 1999 20:27:07 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Michel Lanners <mlan@cpu.lu>
cc: saulngeo@MLE.CO.UK, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Subject: Re: UW SCSI PCI cards
In-Reply-To: <199909101825.UAA14339@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.10.9909122025510.12494-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 10 Sep 1999, Michel Lanners wrote:
> On  10 Sep, this message from Saulnier, Geoff (London) echoed through cyberspace:
> > So, my questions are:
> >   -  what PCI UW SCSI cards are supported in the final version
> 
> Basically all that Linux supports, although some more exotic ones might
> not work on PowerPC...

FYI, my Sym53c875 board (Dawicontrol DC-2976UW) doesn't have an OF ROM, but it
works fine with the {sym,ncr}53c8xx drivers. So OF is not a prerequisite,
unless you want to boot from it as well.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- SONY Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Phone +32-2-7248608 Fax +32-2-7242686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
