Date: Sat, 11 Nov 2000 20:37:32 +1100
From: Steven Hanley <sjh@svana.org>
To: Ethan Benson <erbenson@alaska.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: success sort of with 2.2.10
Message-ID: <20001111203732.A12202@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20001111190841.A8799@wibble.net> <20001110235107.X4577@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20001110235107.X4577@plato.local.lan>; from erbenson@alaska.net on Fri, Nov 10, 2000 at 11:51:07PM -0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 10, 2000 at 11:51:07PM -0900, Ethan Benson wrote:
> On Sat, Nov 11, 2000 at 07:08:41PM +1100, Steven Hanley wrote:
> >
> > All
> >
> > well 2.2.10 will get past the blank screen on my 7220, 2.2.18pre18 and
> > 2.2.17 (came with debian) both dont.
>
> well that rules out quik breakage at least.  progress! ;-)

yes it is good progress to have the fb penguin and some boot messages show
up :)

> one thing i just remembered, did you compile 2.2.17 withOUT
> CONFIG_BOOTX_TEXT  ?  BootXText screws up quik booting on some
> machines apparently.   turning it off has made quik boot properly for
> others.

yes it is compiled out, I didnt know it may cause problems, but I thought
that now I didnt need bootx any more I could get rid of it anyway.

Now when I add the pci ide suport I get a repeatable kernel panic on boot
every time I boot. I typed out the dump, but wont look at tracking it down
just yet, first I will try to work out a way to get hold of a 2.2.14 paulus
tree or similar and see what that does.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
