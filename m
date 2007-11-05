Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id B693BDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Nov 2007 02:59:11 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so214935and
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 05 Nov 2007 07:59:11 -0800 (PST)
Message-ID: <fa686aa40711050759v185e2d03nf6964366f6e40fa2@mail.gmail.com>
Date: Mon, 5 Nov 2007 08:59:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [alsa-devel] [PATCH] [ML403-AC97CR] Fix capture/periodic overrun
	bug.
In-Reply-To: <s5h1wb4na6x.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1194025939.29723.22.camel@localhost>
	<s5h1wb4na6x.wl%tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>, perex@suse.cz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/5/07, Takashi Iwai <tiwai@suse.de> wrote:
> Oh, it seems that your patch was lost in the patch queue before ALSA
> 1.0.15 release.  Sorry, I applied the last one now to ALSA HG tree
> together with this one.
>
> The patch to arch/ppc/syslib/virtex_device.c isn't still applied
> (because it's outside the ALSA HG tree).  For applying this to alsa
> git tree, Jaroslav would need to apply manually.
>
> Jaroslav, could you add it please?

Please don't send this change in through the alsa git tree.  arch/ppc
is semi frozen and changes should really go in via paulus' tree.

I'll take another look at it and see if I can get it in.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
