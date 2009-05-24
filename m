Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id DEE8BDE0C9
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 04:19:59 +1000 (EST)
Received: by gxk20 with SMTP id 20so1179421gxk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 11:19:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090524180023.GA4525@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231303.17919.35877.stgit@terra>
	<fa686aa40905240713g2e79367mec0ba185432a94a@mail.gmail.com>
	<20090524180023.GA4525@sirena.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 24 May 2009 12:19:37 -0600
Message-ID: <fa686aa40905241119t5e85311cj8a181c11b3890f0b@mail.gmail.com>
Subject: Re: [PATCH V2 4/9] Add a few more mpc5200 PSC defines
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 12:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, May 24, 2009 at 08:13:19AM -0600, Grant Likely wrote:
>> On Sat, May 23, 2009 at 5:13 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> > Add a few more mpc5200 PSC defines. More bit fields defines for mpc5200 PSC registers. This patch is going in via Grant's tree.
>
>> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> Jon's commit log says this is going in via your tree - is that the case
> or should I apply it to ASoC?

Nothing else needs it in MPC5200 land and I haven't applied it to my
tree yet.  Go ahead and add it to the ASoC tree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
