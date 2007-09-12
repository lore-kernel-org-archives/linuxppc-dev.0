Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 1D38FDDE30
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 01:08:19 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so288980wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 08:08:15 -0700 (PDT)
Message-ID: <9e4733910709120808i687ab5far924201f8a910759c@mail.gmail.com>
Date: Wed, 12 Sep 2007 11:08:14 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Robert Schwebel" <r.schwebel@pengutronix.de>,
	"Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: Which 2.6 kernel for MPC5200
In-Reply-To: <20070912062819.GI23573@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46E57A9D.2020506@asist.si>
	<fa686aa40709101120u1310845et866b8fa6df7c5154@mail.gmail.com>
	<9e4733910709101622u6978baa6n8618975f75ae1315@mail.gmail.com>
	<20070912062819.GI23573@pengutronix.de>
Cc: Babarovic Ivica <ivica.babarovic@asist.si>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/12/07, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> We have the OSELAS.BSP patch stack for the PCM030 working ontop of
> Linus' git. It still uses an older version of the Bestcom patches, so if
> you do some work in that area, please keep me informed about your
> progress.

What is the best way to proceed? I need to be on current git since we
are integrating a wireless driver that is tracking current git and the
mac80211 work.

I have Phytec (pcm030) and Efika hardware but I don't have a 5200lite.
Our prototype hardware uses the pcm030 module on a custom baseboard.

The best thing for me would be to get a FEC driver merged. That is the
largest piece of code  that is floating around. Getting that merged
would give me a stable base to build future patches on.

I'd also like to get support for the pcm030 (minus real-time) merged.
That isn't a lot of code once FEC is in the kernel.

Domen has posted this driver "[RFC PATCH v0.1] net driver: mpc52xx
fec". I can work on breaking that up, but I don't have a 5200lite so I
will have to port to pcm030. I don't want to start on this if someone
else is already doing it.

-- 
Jon Smirl
jonsmirl@gmail.com
