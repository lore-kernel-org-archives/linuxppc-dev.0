Subject: TiBook-PowerBook XF86Config-4 - gpm
From: Vincent Katz <vincent.katz@laposte.net>
To: paulus@samba.org
Cc: =?ISO-8859-1?Q?J=94rn?= Nettingsmeier <nettings@folkwang-hochschule.de>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	jhartmann@precisioninsight.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15346.46026.126227.601357@cargo.ozlabs.ibm.com>
References: <20011114230308.04E9D18077@haven.ozlabs.ibm.com>
	<15346.46026.126227.601357@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 15 Nov 2001 15:23:48 +0100
Message-Id: <1005834230.14694.155.camel@avalon>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,
me too, i have a tibook and i'm interesting for your XF86Config-4.

I have a little probleme with the console mode and gpm (v:1.19.6), for
the cut and paste i have an alteration of the characters, i don't know
why ?

thanks

On 15 Nov 2001 05:11:22 +1100, Paul Mackerras wrote:
> J”rn Nettingsmeier writes:
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


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
