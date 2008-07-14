Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 5C01CDDF54
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 03:22:08 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1380759anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 10:22:06 -0700 (PDT)
Message-ID: <fa686aa40807141022y18ea2a70qa68665f310e9b505@mail.gmail.com>
Date: Mon, 14 Jul 2008 11:22:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com,
	jonsmirl@gmail.com
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
In-Reply-To: <20080714171632.GH25448@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>
	<20080714171632.GH25448@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 11:16 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jul 14, 2008 at 11:06:34AM -0600, Grant Likely wrote:
>
>> I'm okay with that.  How about fsl/mpc5200-of-machine.c for now?
>> (only the mpc5200 i2s driver uses it at the moment).  It can always be
>> renamed if other folks want to use it for other chips.
>
> That seems reasonable so long as you're happy with it, though it does
> seem to be going to the other extreme in terms of broadness :)

heh; I don't care.  This stuff is all going to be in flux anyway, so
change is inevitable whatever is chosen now.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
