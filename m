Date: Wed, 24 Feb 1999 13:40:19 -0500 (EST)
From: Tom Vier <nester@erols.com>
Reply-To: Tom Vier <thomassr@erols.com>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Franz Sirl <Franz.Sirl@munich.netsurf.de>,
        mklinux-development-system@public.lists.apple.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: egcs-1.1.1-1c bug (was Re: major ksyms problem)
In-Reply-To: <99022322220600.00836@ns1102.munich.netsurf.de>
Message-ID: <Pine.LNX.4.05.9902241335420.6173-100000@localhost.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Feb 1999, Franz Sirl wrote:

> >it is an egcs bug. egcs-1.1.1-1c failss to build working bsd_comp.o,
> >ppp_deflate.o, and hfs.o; egcs-1.0-2e.ppc.rpm builds it perfectly. i'm
> >getting a newer build of egcs right now, to see if it's fixed.
> 
> What is the problem with these modules? Give a better description on what you
> mean with "working"? They work perfectly for me with a self-compiled 2.2.1
> kernel, and I compiled working modules with multiple kernel versions
> since the 
> egcs-1.1 alpha phase.
> If your only problem is the "unhandled relocation type", install a newer
> modutils package (>=2.1.121), that will fix it.

yup, that fixed it. 8) i wonder what changed in egcs between 1.0 and
1.1.1 that makes the problem arise.

--
Tom Vier - 0x82B007A8
thomass@erols.com        | goto the Zero Page at:
Tortured Souls Software  | http://www.erols.com/thomassr/zero/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
