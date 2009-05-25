Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 13A9DDE016
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 23:22:58 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1507070ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:22:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090525093439.GA18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013847.3073.55951.stgit@terra>
	<fa686aa40905242326y6a88af84n40f23759661a6cd0@mail.gmail.com>
	<20090525093439.GA18290@sirena.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 25 May 2009 07:22:37 -0600
Message-ID: <fa686aa40905250622h3c2076c2l21a5dd9f29e5f78e@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] Main rewite of the mpc5200 audio DMA code
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

On Mon, May 25, 2009 at 3:34 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, May 25, 2009 at 12:26:27AM -0600, Grant Likely wrote:
>> On Sun, May 24, 2009 at 7:38 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> > +/* ------------------------------------------------------------------=
---
>> > + * Sysfs attributes for error monitoring
>> > + */
>
>> All this sysfs stuff should be dropped from this patch. =A0It is an
>> abuse of sysfs and I never should have written it this way. =A0Feel free
>> to put it in a separate patch so others can use it if they really need
>> it, but I'd like it to not be kept in mainline.
>
> If this is going to be kept it should be in debugfs like I said in
> response to the v2 posting.

exactly.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
