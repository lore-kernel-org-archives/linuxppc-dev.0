Date: Tue, 19 Oct 1999 18:36:49 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David N. Welton" <davidw@linuxcare.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel questions
In-Reply-To: <19991018121353.D17058@bassano.linuxcare.com>
Message-ID: <Pine.LNX.4.05.9910191836220.28274-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 18 Oct 1999, David N. Welton wrote:
> > Yes, it's correct. However, I beleive the kernel is compiled to boot
> > on CHRP _and_ PowerMacs, and so the ADB support is needed. Also, the
> > CHRP definition states that CHRP machines can have an ADB controller
> > too.
> 
> There are a few options:
> 
> PowerMac
> Prep/MTX
> CHRP
> PowerMac/PReP/CHRP
> Gemini
> APUS
> 
> I'm compiling as CHRP, and since ADB is selectable as an option, it
> seems it could be added in anyway, pmac or not?
> 
> So would it be a worthwhile endeavour to try and ifdef this stuff out,
> for those of us who don't need it?

Isn't that already done in the latest 2.3.x?

Greetings,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
