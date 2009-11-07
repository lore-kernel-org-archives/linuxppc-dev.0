Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f212.google.com (mail-gx0-f212.google.com
	[209.85.217.212]) by ozlabs.org (Postfix) with ESMTP id 44DCCB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 Nov 2009 03:52:51 +1100 (EST)
Received: by gxk4 with SMTP id 4so1971377gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 08:52:49 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091107125713.GF3228@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107125713.GF3228@sirena.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 7 Nov 2009 09:52:27 -0700
Message-ID: <fa686aa40911070852h5d09acafq4c55d838b7fb461e@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/6] Fixups to MPC5200 ASoC drivers
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 7, 2009 at 5:57 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Nov 07, 2009 at 01:33:40AM -0700, Grant Likely wrote:
>> So, please test. =A0Let me know if these work or not. =A0I've don't know
>> if the last patch (Add fudge factor...) is needed or not.
>
> I've applied patches 1-5 since they seem fairly clear code cleanups and
> fixes. =A0If they've introduced any problems we can fix them incrementall=
y.
> I'll wait to see what the outcome of testing is for patch 6.

Cool, thanks!

> As I mentioned on IRC testing with PulseAudio would be good for this -
> it makes more demands on the quality of the DMA implementation than most
> applications.

I had trouble getting pulseaudio to work on my headless system.
Couldn't get clients to connect.  I'll hack on it again next week.

g.



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
