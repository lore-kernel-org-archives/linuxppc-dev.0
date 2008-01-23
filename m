Return-Path: <scottwood@FREESCALE.COM>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C033DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 12:53:26 +1100 (EST)
Message-ID: <47968EAF.9070809@freescale.com>
Date: Tue, 22 Jan 2008 18:47:43 -0600
From: Scott Wood <scottwood@FREESCALE.COM>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/3 v3] Add StorCenter DTS first draft.
References: <E1JHRkS-0005du-O1@jdl.com>	<fa686aa40801221449p28889ea5r68bd726726558dc0@mail.gmail.com>
	<1201048396.6807.52.camel@pasglop>
In-Reply-To: <1201048396.6807.52.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> I think there's an ongoing argument as to whether the absence of
> #address-cells should be the same as #address-cells = 0 in that specific
> case but I'm not sure the code does the right thing so let's have it
> explicit.

I've had no problems leaving it out.

-Scott
