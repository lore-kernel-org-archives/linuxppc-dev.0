Date: Sat, 20 May 2000 15:38:37 -0700 (PDT)
From: Matt McLean <keys@yikes.com>
To: Ethan Benson <erbenson@alaska.net>
cc: Debian-PowerPC <debian-powerpc@lists.debian.org>,
        Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Paul's 2.2.15 does not boot a 7200
In-Reply-To: <20000520002947.A6452@plato.local.lan>
Message-ID: <Pine.BSF.4.21.0005201535200.59827-100000@nerf.yikes.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey,

That sounds like it's not recognizing your onboard video...

Be sure you have CONFIG_FB, CONFIG_FB_OF, and CONFIG_FB_PLATINUM set to
yes in your kernel config...

Otherwise, do you have a strange CPU upgrade?  Did earlier versions of
Paul's kernel work on your machine?

-Matt

On Sat, 20 May 2000, Ethan Benson wrote:

> Hi,
>
> I have rsynced paul's stable kernel tree to 2.2.15 proper (no pre),
> this kernel works quite well with a G3 via yaboot, but will not boot a
> 7200 (via quik).  I have tried my own custom config as well as Paul's
> config included in the rsync tree.  quik loads the kernel successfully
> and prints `Copying Device tree' just like it does for 2.2.14 but the
> monitor just stays black and nothing else happens, it never boots any
> further.
>
> the quik used is the current debian quik sources, patched by Dan
> Jacobowitz to support powermacs. (there is no macos on this machine so
> bootx is not an option, nor testable)
>
> has anyone else had problems with 2.2.15 on 7200s?
>
> the system runs Debian potato, and runs paul's 2.2.14.
>
> --
> Ethan Benson
> http://www.alaska.net/~erbenson/
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
