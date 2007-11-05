Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 27F7BDDFB0
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 07:03:54 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so234581and
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 12:03:53 -0800 (PST)
Message-ID: <fa686aa40711051203v4de1844el6884565a77116e11@mail.gmail.com>
Date: Mon, 5 Nov 2007 13:03:53 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
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

On 11/5/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> This is my first pass at reworking the Freescale i2c driver. It
> switches the driver from being a platform driver to an open firmware
> one. I've checked it out on my hardware and it is working.

Isn't this device core also used in the fsl coldfire socs?

If so, it needs to have both platform bus and of_platform bus
bindings.  This is easy to do as long as you keep device probing and
initialization in separate routines.  See drivers/serial/uartlite.c
for an example.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
