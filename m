Message-ID: <3BF388E5.B0979DFE@folkwang-hochschule.de>
Date: Thu, 15 Nov 2001 10:20:37 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: AGP : ATI128,powerpc
References: <20011114230308.04E9D18077@haven.ozlabs.ibm.com> <15346.46026.126227.601357@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> J?rn Nettingsmeier writes:
>
> > i've been using ben's tree for a powerbook for quite some time, and
> > i used to see the same error, so i disabled agp and dri.
> >
> > has this been fixed lately ?
> > i'm desperate for faster video. 2d performance under x is pathetic,
> > and scrolling is a major pita.
>
> Getting reasonable 2D performance for things like scrolling doesn't
> need DRI and/or AGP, you just need an X server that knows how to drive
> the rage 128 chip.  I'm using XFree86 4.1.0 (from debian unstable) on
> my Ti powerbook and it works just fine.  I can send you my
> XF86Config-4 if you like (you would need to tweak it a little for a
> pismo) or you could ask Ben Herrenschmidt for the config he uses on
> his pismo.

paul, ben, thanks a lot for your helpful replies.
i'm using a framebuffer xserver, which is of course the reason for
the sloppy scrolling.
somehow i thought you had to use a framebuffer (which, some reading
turned out, is only true for the console, not x).

best,

jörn


--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
