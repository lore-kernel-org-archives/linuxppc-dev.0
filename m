Date: Fri, 21 Jan 2000 14:19:33 -0700 (MST)
From: Stephen Edie <sedie@terraplex.com>
To: brad allison <jackal@aol.net>
cc: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB problems in 2.2.14pre9
In-Reply-To: <Pine.SGI.4.00.10001211606390.21990-100000@osiris.office.aol.com>
Message-ID: <Pine.LNX.4.10.10001211414280.6976-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Oh yes, I am using a USB keyboard right now.  It seems to happen whenever
more than three keys are simultaneously down...  When the fourth key is
pressed, it isn't reported.  At this point, releasing any of the four keys
causes duplicated key strokes to be reported.  Strange.

Stephen

Terra Soft Solutions, Inc.
 Yellow Dog Linux
 "The Ultimate Companion for a Dedicated Server"
 http://www.yellowdoglinux.com/

 Black Lab Linux
 Workstations and advanced, Parallel Solutions
 http://www.blacklablinux.com/

On Fri, 21 Jan 2000, brad allison wrote:

>
>
> I'm seeing the strange problem when I type cd really fast that it comes
> out as cdcd or cdc .
>
> Other people who's used my keyboard see the same thing, but you have to
> type it really fast.  It seems almost random.
>
> I didn't see the problem until I switch to 2.2.14pre9 and
> Xpmac.rage128.usb.rev6 .  I backed out of Xpmac.rage128.usb.rev6 to
> XF68_FBDev because of cut-and-paste problems with Xpmac.rage128.usb.rev6
> and I'm still seeing this weird "cdcd" problem.
>
> Anyone else seeing this?
>
> -b
>
> --
> AOL SAPI    jackal@aol.net    jackal@kmfms.com    703.265.0908   AIM:jackal242
> http://jackal.fudge.org        `I was never more certain of how far away I was
> from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
