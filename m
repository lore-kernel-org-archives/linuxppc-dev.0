Content-Type: text/plain;
  charset="iso-8859-1"
From: Ian Reinhart Geiser <geiseri@linuxppc.com>
To: William Blew <wblew@home.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OT: Where do I send a PPC centric XF4 patch?
Date: Mon, 19 Feb 2001 17:12:04 -0600
References: <Pine.LNX.4.30.0102191339490.19276-100000@apollo.kulian.net>
In-Reply-To: <Pine.LNX.4.30.0102191339490.19276-100000@apollo.kulian.net>
MIME-Version: 1.0
Message-Id: <01021917120400.15326@elysium.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


send the patch to:
	Ani Joshi <ajoshi@shell.unixbox.com>
he is doing the ppc X stuff.
thanks for your hard work
-ian reinhart geiser

On Monday February 19, 2001  3:51 pm, William Blew wrote:
> First, if this is offtopic I apologize...
>
> I am putting the finishing touches on a patch to the XF4 tree that
> provides for:
>
> 1) Fixup the "ati" driver so that it doesn't SIGSEGV on the PPC
>    when the XFree86 server doesn't support loadable modules. I.E>
>
> 	in "xc/config/cf/host.def" "DoLoadableServer NO" appears
>
>    I found that this made debugging XF4 under PPC very doable..
>
> 2) Add hardware cursor support for mach64 to the "ati" driver.
>
>    While this support whould work on an x86, I have a pmac ;-)
>
> Questions:
>
> 1) Where do I send this patch? It is based on the 4.0.2-ie source from
> linuxppc.org that included the PPC drivers' support. Do I just send it
> to fixes@xfree.org? Or perhaps to one of the PPC developers here on
> this list, for integration into the ongoing PPC drivers' work?
>
> 2) Is there an xfree.org contributor on this mailing list who is willing
> to take such patches and incorporate them into the ongoing XF4 (PPC) work
> and/or pass them on the appropriate people?
>
> Or, just let me who those people are and I'll pass such things on to them
> myself.
>
> Given that this is the first interesting patch I have produced I am still
> a little undertain as to how these things typically work...
>
> Thanks in advance.
> --
> William Blew, wblew@home.com
> Gamer by Choice, Geek by Birth
>
>

--
===================================================
First, we reload the gun. Then, pointing to our feet, we shoot.
Now we think that oughta hurt, but hey - we saw this coming!
===================================================
Ian Reinhart Geiser
LinuxPPC & KDE Developer
LinuxPPC Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
