Date: Sat, 11 Aug 2001 11:05:54 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hollis Blanchard <hollis@austin.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: VGA console endian bug
Message-ID: <20010811110554.E13486@suse.de>
References: <20010810161335.A29271@austin.ibm.com> <Pine.LNX.4.05.10108111032070.8907-200000@callisto.of.borg> <20010811104509.D13486@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010811104509.D13486@suse.de>; from olh@suse.de on Sat, Aug 11, 2001 at 10:45:09AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 11, Olaf Hering wrote:

>
> On Sat, Aug 11, Geert Uytterhoeven wrote:
>
> >
> > Note that I've been having a fight with Olaf Hering about this as well :-)
>
> And the battle goes on :)
>
> It really fixes my VGA problems so far, but I guess the bug is somewhere
> else.
> We use a patch to display the kernel version above the framebuffer logo.
> It works on intel and on sparc, but it gives the usual garbage for the
> version chars on ppc.
>
> It uses the fbcon_putcs() function. I will see how it works without that
> vga patch.

sigh,

I removed the vga patch and the version string appears still as garbage.
We have the clgen driver in the kernel and it prints its messages also
as garbage, this was always the case, also in 2.2. That does not happen
with the vga patch.

The bootlogo-version patch can be found here:
/mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/patches/50_bootlogo-ver-2.4.5.gz



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
