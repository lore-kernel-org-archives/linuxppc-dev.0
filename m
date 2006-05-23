Return-Path: <sjoerd@spring.luon.net>
Received: from fire.luon.net (simons.xs4all.nl [80.126.201.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fire.luon.net", Issuer "Luon Network CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B6F2367B17
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 02:01:02 +1000 (EST)
Date: Tue, 23 May 2006 17:41:37 +0200
To: Johannes Berg <johannes@sipsolutions.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
Subject: Re: snd-aoa status update / automatic driver loading
Message-ID: <20060523154137.GA3205@spring.luon.net>
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<87wtcirw0y.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wtcirw0y.fsf@briny.internal.ondioline.org>
From: sjoerd@spring.luon.net (Sjoerd Simons)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 11:20:29PM +1000, Paul Collins wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > On Thu, 2006-05-18 at 10:25 +0300, Eddy Petri??or wrote:
> >
> >> Any chance for 5,2 ? What is needed for it? Codec only?
> >
> > I don't know. If you try loading the modules, the kernel will tell you
> > something about an unhandled layout id. Alternatively, you can find the
> > layout-id file in your /proc/device-tree/ and tell me the number in it.
> > The rest I can figure out.
> 
> I have a PowerBook5,4 here and I'd be happy to test support for it.
> The hardware is identified by snd-powermac as "PowerMac Snapper" and
> the layout ID appears to be "3".

I wanted to test on my PowerBook5,2. Uhfortunately i can't find no layout-id
file for the sound device or any other layout-id file for that matter:

$ find /proc/device-tree | grep -i layout 
/proc/device-tree/memory@0/ram-layout-architecture      

Futhermore one loading the i2sbus module it only gives some information in
dmesg once every two tries ? No errors are shown when there is no output.

Probably not very usefull, but when i get output it shows the following:

i2sbus: mapped i2s control registers
i2sbus: control register contents:
i2sbus:    fcr0 = 0x0
i2sbus:    cell_control = 0x0
i2sbus:    fcr2 = 0xa2caec
i2sbus:    fcr3 = 0x0
i2sbus:    clock_control = 0x0
i2sbus control destroyed

  Sjoerd
-- 
Life exists for no known purpose.
