Message-ID: <3BF3B237.2F29F8D6@folkwang-hochschule.de>
Date: Thu, 15 Nov 2001 13:16:55 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: running hot ! [was:Re: AGP : ATI128,powerpc]
References: <20011114230308.04E9D18077@haven.ozlabs.ibm.com> <15346.46026.126227.601357@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello *

thanks to your hints, i was able to speed up my x performance by
switching to the ati x server.
scrolling is now what god intended it to be.

i have also compiled the latest benh kernel with agp and ati
support.
all runs fine, although i have not yet been able to run 3d stuff,
probably a missing x module.

one peculiar thing: the trackpad button of my pismo gets quite hot,
which it did not do before.
it's not too extreme, but the difference to my old setup
(xfree3.3.6, framebuffer xserver, old kernel w/o agp and ati
support) where the button used to be totally cold is remarkable.

has anyone seen that, too ?

regards,

jörn


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
>
> Paul.
>

--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
