From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 3 Nov 2003 16:31:43 -0700
To: Wolfgang Denk <wd@denx.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031103233143.GA19177@zenos.farnsworth.org>
References: <20031101093633.E4EF3C59E4@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031101093633.E4EF3C59E4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Nov 01, 2003 at 09:36:28AM +0000, Wolfgang Denk wrote:
> Dear Tom,
>
> in message <20031031155445.GA25446@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > > Will you accept these patches, and put the stuff  into  the  official
> > > trees?
> >
> > What would be best is a patch against 2.4.23-pre9 (or semi-recent bk
> > snapshot) posted to linuxppc-dev and/or linuxppc-embedded.
>
> Please find attached below a  patch  against  2.4.23-pre9  (ChangeSet
> 1.1397, BK Key paulus@samba.org|ChangeSet|20031030220219|08345).
>
> I've also uploaded the patch to
> ftp://ftp.denx.de/pub/ppc/linux/bk_2_4_devel-1.1397-MPC5200.patch.gz
>
> Best regards,
>
> Wolfgang Denk

Thanks for motivating me to action, Wolfgang. :-)

The above patch is based on an early, unpublished version of my mpc5200
port.  While I was quite surprised to find it in Wolfgang's tree, I'm
confident that Wolfgang received it in good faith.

I did not publish the port because the ethernet support relies on a
Motorola-written DMA subsystem with a proprietary license that doesn't
permit redistribution.  A month ago, Motorola finally sent me an
updated, GPLed version of the DMA controller code.  I merged the new
version, but the DMA API has changed and I've been busy with other things
so ethernet isn't quite working again, yet.  I've made several changes
to the 5200 port as well.

I will post my updated code to this list this week and would prefer
to see it merged rather than my older code contained in the above patch.

Thanks,

-Dale Farnsworth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
