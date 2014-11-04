Return-Path: <linux@roeck-us.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C3C01A0B58
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 16:11:21 +1100 (AEDT)
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D03A14003E
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2014 16:11:20 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XlWOh-001b9t-Ba
 for linuxppc-dev@ozlabs.org; Tue, 04 Nov 2014 05:11:15 +0000
Message-ID: <54585FF0.2030609@roeck-us.net>
Date: Mon, 03 Nov 2014 21:11:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Convert power off logic to pm_power_off topic branch
References: <1415076451.24950.4.camel@concordia>
In-Reply-To: <1415076451.24950.4.camel@concordia>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/03/2014 08:47 PM, Michael Ellerman wrote:
> Hi Guenter,
>
> I've put the pm_power_off patch in a topic branch:
>
>    https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=topic/pm-power-off
>

Hi Michael,

Excellent.

Right now all I can do is to wait for Rafael. He was not happy with earlier versions
of the series and did not yet comment on the most recent version. Since we are already
at 3.18-rc3 without making real progress, it may well be that the series is going
to miss 3.19.

Guenter
