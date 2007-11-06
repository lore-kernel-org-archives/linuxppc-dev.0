Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id 87736DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 11:41:40 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1474105rvf
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 16:41:39 -0800 (PST)
Message-ID: <9e4733910711051641m5ff0e651ke9a43daa51fd14b@mail.gmail.com>
Date: Mon, 5 Nov 2007 19:41:39 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <472F8267.8070106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> >>> One side effect is that legacy style i2c drivers won't work anymore.
> >> If you mean legacy-style client drivers, why not?
> >
> > i2c_new_device() doesn't work with legacy-style client drivers.
>
> No, but they should still work the old way.

I'm not in favor trying to support both legacy and new style i2c
drivers.  It took me all of five minutes to convert an existing legacy
driver to the new style. Pretty much all you need to do is delete code
(about 100 lines). So I'd recommend converting the drivers we are
interest in instead of trying to support both types.

-- 
Jon Smirl
jonsmirl@gmail.com
