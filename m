Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id 8CD05DE0E3
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 13:47:45 +1000 (EST)
Received: by gxk20 with SMTP id 20so2391299gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 20:47:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ed82fe3e0905252041u367cac2fk80c9316c0236e340@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221511.21370.81405.stgit@terra>
	<ed82fe3e0905252041u367cac2fk80c9316c0236e340@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 25 May 2009 21:47:24 -0600
Message-ID: <fa686aa40905252047g6c88efa9t2b9b864f2d2023f9@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4 3/5] AC97 driver for mpc5200
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 9:41 PM, Timur Tabi <timur@freescale.com> wrote:
> On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> + =A0 =A0 =A0 spin_event_timeout(1, 3, 0, rc);
>
> Ugh, don't do this. =A0Just use udelay!

heh; indeed.  My objection to udelay is that it burns cycles it the
test loop that could be used to decide whether or not the loop is
complete.  Not an issue when the explicit goal is to burn a fixed
number of cycles.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
