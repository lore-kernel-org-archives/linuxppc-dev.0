Date: Sun, 6 Aug 2000 21:31:00 +0200
From: Olaf Hering <olh@suse.de>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Yaboot problems
Message-ID: <20000806213100.B20317@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <398E0BAE.82915F86@denise.shiny.it> <20000806211446.A20317@suse.de> <398E0FA8.BFB5D7D3@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <398E0FA8.BFB5D7D3@denise.shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 06, Giuliano Pochini wrote:

>
> > > Oh, another thing... How can I type the "\" char in OpenFirmware using the USB
> > > keyboard ?!?  I had to attach the old (and MUCH BETTER) ADB keyb to type it.
> >
> > If you can type on a ADB keyboard you have proably a B&W G3. Some
> > keyboards can not produce the \ key. I guess the OF keymap is broken.
>
> Oh, this is a really useful info. Tnx !!  :-)))
>
> > The os-chooser gives you the choice between MacOS and yaboot, not
> > yaboot.
>
> So I need to change the OF boot device each time I want to boot the other OS
> ??

Nope, point it to your Linux boot partition and load the os-chooser
script.
You can use ybin or lilo to automate that. ybin is at ppclinux.apple.com
and lilo is at ftp://ftp.suse.com/pub/projects/powerpc/lilo/


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
