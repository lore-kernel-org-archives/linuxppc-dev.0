Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 54A6BDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 13:01:42 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so653731ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2009 20:01:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4b73d43f0905071912k4bcc8821nabfa27aa5b1f587b@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-9-git-send-email-wd@denx.de>
	<fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
	<20090506221908.3927583420E8@gemini.denx.de>
	<fa686aa40905061551l8cf5940sf4d4cbf34331cf9a@mail.gmail.com>
	<fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
	<4b73d43f0905071912k4bcc8821nabfa27aa5b1f587b@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 7 May 2009 21:01:21 -0600
Message-ID: <fa686aa40905072001y1424feb8x2fb3149a0c84fc9a@mail.gmail.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
To: John Rigby <jcrigby@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 7, 2009 at 8:12 PM, John Rigby <jcrigby@gmail.com> wrote:
> Ok, the interrupt enabling should happen in the driver.=A0 Should it key =
off
> compatible or should a new property be added like the existing 5200 clock=
ing
> property?

key off compatible.  And the 5200 clocking property has been depreciated.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
