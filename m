From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15346.46026.126227.601357@cargo.ozlabs.ibm.com>
Date: Thu, 15 Nov 2001 05:11:22 +1100 (EST)
To: Jrn Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	Vincent Katz <vincent.katz@laposte.net>,
	jhartmann@precisioninsight.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: AGP : ATI128,powerpc
In-Reply-To: <20011114230308.04E9D18077@haven.ozlabs.ibm.com>
References: <20011114230308.04E9D18077@haven.ozlabs.ibm.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


J”rn Nettingsmeier writes:

> i've been using ben's tree for a powerbook for quite some time, and
> i used to see the same error, so i disabled agp and dri.
>
> has this been fixed lately ?
> i'm desperate for faster video. 2d performance under x is pathetic,
> and scrolling is a major pita.

Getting reasonable 2D performance for things like scrolling doesn't
need DRI and/or AGP, you just need an X server that knows how to drive
the rage 128 chip.  I'm using XFree86 4.1.0 (from debian unstable) on
my Ti powerbook and it works just fine.  I can send you my
XF86Config-4 if you like (you would need to tweak it a little for a
pismo) or you could ask Ben Herrenschmidt for the config he uses on
his pismo.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
