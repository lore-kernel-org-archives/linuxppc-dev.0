Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 7A2E2DDF0A
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jul 2008 04:14:42 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1294286anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 11:14:40 -0700 (PDT)
Message-ID: <fa686aa40807121114u2f7c8ae6p1c1919c713e53c1a@mail.gmail.com>
Date: Sat, 12 Jul 2008 12:14:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com,
	jonsmirl@gmail.com
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
In-Reply-To: <20080712180959.GB6523@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<20080712180959.GB6523@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2008 at 12:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 12, 2008 at 02:39:39AM -0600, Grant Likely wrote:
>
>> ASoC Codec driver for the TLV320AIC26 device.  This driver uses the ASoC
>> v1 API, so I don't expect it to get merged as-is, but I want to get it
>> out there for review.
>
> I've not reviewed this revision of these drivers yet but I just wanted
> to point out that there's absoluely no problem with merging v1 drivers -
> so long as a driver uses the existing merged APIs there's no issue from
> that point of view.

Oops, I forgot to update my commit messages.  I'll probably repost v3
of the series this evening and I'll fix this.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
