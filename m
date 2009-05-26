Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id EB29BDE0AE
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 13:41:25 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1846835qwe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 20:41:24 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20090525221511.21370.81405.stgit@terra>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221511.21370.81405.stgit@terra>
Date: Mon, 25 May 2009 22:41:23 -0500
Message-ID: <ed82fe3e0905252041u367cac2fk80c9316c0236e340@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4 3/5] AC97 driver for mpc5200
From: Timur Tabi <timur@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
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

On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> + =A0 =A0 =A0 spin_event_timeout(1, 3, 0, rc);

Ugh, don't do this.  Just use udelay!

--=20
Timur Tabi
Linux kernel developer at Freescale
