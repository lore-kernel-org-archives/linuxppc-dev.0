Return-Path: <neko@genesi-usa.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by ozlabs.org (Postfix) with ESMTP id 55F36DE3F9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 22:02:37 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so1370334fkz.9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 05:02:34 -0700 (PDT)
Message-ID: <4809DF54.2080609@genesi-usa.com>
Date: Sat, 19 Apr 2008 13:02:28 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: RFC: MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>	
	<200804171619.56615.jbe@pengutronix.de>	
	<4808C1BE.1050607@fang.fa.gau.hu>	
	<200804181802.34833.jbe@pengutronix.de>	
	<4808E469.9020408@genesi-usa.com>
	<fa686aa40804181553q622b3c1fi7a302712abe79be1@mail.gmail.com>
In-Reply-To: <fa686aa40804181553q622b3c1fi7a302712abe79be1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> On Fri, Apr 18, 2008 at 12:11 PM, Matt Sealey <matt@genesi-usa.com> wrote:
>>  Juergen Beisert wrote:
> BTW, is anyone trying to shepherd this driver into the ALSA tree?  Its
> out of my area of expertise and responsibility, so I haven't been
> pursuing it.

We (well, I) were going to try but we got some oopses; from one thing or another,
but with Juergen's fixes and cell-index in place, now it plays audio.

Now it can be pushed to ALSA on that basis, but I'm still trying to get my
head around where we need to throw patches and if it goes into ALSA Drivers
first or the kernel or both? It's kind of convoluted compared to the ease
of just CC'ing netdev or linux-ide..

If you want to push it, please do, but also I guess it'll need to be bundled
with the cell-index patch for the fixups (we couldn't get it to make the
property for some odd reason) or a change to using addresses in the driver
for PSC selection (Juergen's original patch did this anyway)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
