Return-Path: <jonsmirl@gmail.com>
Received: from ro-out-1112.google.com (ro-out-1112.google.com [72.14.202.176])
	by ozlabs.org (Postfix) with ESMTP id 9ED11DDDD8
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 07:41:48 +1100 (EST)
Received: by ro-out-1112.google.com with SMTP id p7so2198384roc
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 12:41:46 -0800 (PST)
Message-ID: <9e4733910711051241o30cdd476lfabca87fdd093364@mail.gmail.com>
Date: Mon, 5 Nov 2007 15:41:46 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>
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

Is there any way to have the i2c chip modules match on the device tree
and be automatically loaded? This is complicated by the fact that
these modules are used on other platforms.

If there is a way to do this for the i2c bus I can apply the same code
to the audio bus as well.

-- 
Jon Smirl
jonsmirl@gmail.com
