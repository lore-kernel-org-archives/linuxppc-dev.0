Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id D674F2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 12:58:01 +1100 (EST)
Message-ID: <525F4421.3090404@roeck-us.net>
Date: Wed, 16 Oct 2013 18:57:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix irq_of_parse_and_map() return value
 check
References: <1380773722-1295-1-git-send-email-linux@roeck-us.net>
 <20131003155816.GU27287@sirena.org.uk>
In-Reply-To: <20131003155816.GU27287@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>,
 Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2013 08:58 AM, Mark Brown wrote:
> On Wed, Oct 02, 2013 at 09:15:22PM -0700, Guenter Roeck wrote:
>> irq_of_parse_and_map() returns 0 on error, not NO_IRQ.
>
> Applied, thanks.
>
Hi Mark,

do you plan to send this patch upstream anytime soon ?

It fixes an xtensa build problem, so it would be great if it could find its way into 3.13.

Thanks,
Guenter
