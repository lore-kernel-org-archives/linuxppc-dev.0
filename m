From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent Katz <vincent.katz@laposte.net>
Cc: <paulus@samba.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: TiBook-PowerBook XF86Config-4 - gpm
Date: Thu, 15 Nov 2001 15:47:07 +0100
Message-Id: <20011115144707.11171@smtp.adsl.oleane.com>
In-Reply-To: <1005834230.14694.155.camel@avalon>
References: <1005834230.14694.155.camel@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>hi,
>me too, i have a tibook and i'm interesting for your XF86Config-4.
>
>I have a little probleme with the console mode and gpm (v:1.19.6), for
>the cut and paste i have an alteration of the characters, i don't know
>why ?

This is a problem when VGA console support is enabled in the kernel
config. (Beware that if you disable it, you must make distclean before
recompiling to get proper display).

I know Geert had a fix for that, I'm not sure if that was included in
upstream sources or not as I didn't have this option checked for monthes
in my kernel.

For this machine (tipb), you should really use either the linuxppc_2_4_devel
tree or my rsync. (The only difference for you here beeing that my rsync
will bring the AGP stuff).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
