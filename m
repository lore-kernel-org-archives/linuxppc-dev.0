Date: Sat, 29 Jul 2000 19:00:25 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Lionel TAILLURAT <Lionel.TAILLURAT@ecrin.com>
cc: ppc_mailing_list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: -= MVME 2300 boot args=-
In-Reply-To: <005b01bff72a$dc426890$a66d34c0@oleane.com>
Message-ID: <Pine.HPX.4.10.10007291857420.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 26 Jul 2000, Lionel TAILLURAT wrote:

>
> Hi,
>
> I have a full working kernel with VME bus support (thx Gabriel for your
> patch and your help).
>
> The problem now is that I can't have the boot args working !
>
> During the configuration of the kernel, I write "root=/dev/sda2
> console=ttyS0" in the "initial kernel command string" , and only
> "console=ttyS0" is shown at boot prompt and the kernel don't see my
> haddrive!
>
> If I use the command (in PPCBUG):
> GEVEDIT bootargs
> bootargs=root=/dev/sda2 console=ttyS0

Prepboot still ha to be upgraded to take the arguments from the NVRAM. If
you wnat to give it a try, it's not that complex,  just that I never fond
the time to do it. It also still ignores the config option. Sorry...

Nevertheless for the root device option, the right way to do it would be
to use the same scheme as the Intel port. You can type make zImage
ROOTDEV=/dev/sda2 for example. By default, it will automagically (on
Intel pc) take the current root device which is very convenient.

> Whats wrong ?

My code :-(

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
