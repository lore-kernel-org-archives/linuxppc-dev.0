Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 0FA11DDFEC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:19:11 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-9-git-send-email-wd@denx.de>
	<fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
Date: Thu, 07 May 2009 00:19:08 +0200
Message-Id: <20090506221908.3927583420E8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	Detlev Zundel <dzu@denx.de>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com> you wrote:
> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
> > From: Piotr Ziecik <kosmo@semihalf.com>
> >
> > - Enabled I2C interrupts on MPC5121.
> > - Updated Kconfig for i2c-mpc driver.
> 
> I think this workaround belongs in the driver itself.

Sorry, I don't get it. Which workaround? What exactly should I change?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Time is an illusion perpetrated by the manufacturers of space.
