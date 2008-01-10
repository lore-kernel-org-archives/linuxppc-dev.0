Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D4BCDDFD7
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 10:19:16 +1100 (EST)
Message-ID: <4786A7E6.8040503@freescale.com>
Date: Thu, 10 Jan 2008 17:19:02 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH v2] [ALSA] Add ASoC drivers for the Freescale
	MPC8610 SoC
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>	<12000050682718-git-send-email-timur@freescale.com>	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>	<4786A650.2080107@freescale.com>
	<fa686aa40801101517q2d4e6673l995ef4123f0d0ad4@mail.gmail.com>
In-Reply-To: <fa686aa40801101517q2d4e6673l995ef4123f0d0ad4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

>> As for the GUTS driver, well, I just program a few registers at startup, and I
>> don't think any other driver touches them.
> 
> Okay; at some point in the future they'll need to be accessed from a
> common routine too.

I'll add that to my to-do list.

-- 
Timur Tabi
Linux kernel developer at Freescale
