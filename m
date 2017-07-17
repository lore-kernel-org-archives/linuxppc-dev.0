Return-Path: <garsilva@embeddedor.com>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.143.52])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9qrf0f44zDrCm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 14:22:25 +1000 (AEST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 338EA314CB8
 for <linuxppc-dev@lists.ozlabs.org>;
 Sun, 16 Jul 2017 23:22:21 -0500 (CDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
To: Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
 <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
 <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
 <1499969891.4457.59.camel@perches.com>
 <20170714110233.fqkmgy7kyhje7mfy@sirena.org.uk>
 <1500030501.4457.70.camel@perches.com>
 <20170714112511.nhcgu2ogpufgele5@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <607d5ac9-5452-a13b-63b1-52a9a2c61cc1@embeddedor.com>
Date: Sun, 16 Jul 2017 23:22:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170714112511.nhcgu2ogpufgele5@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark, Joe,


On 07/14/2017 06:25 AM, Mark Brown wrote:
> On Fri, Jul 14, 2017 at 04:08:21AM -0700, Joe Perches wrote:
>> On Fri, 2017-07-14 at 12:02 +0100, Mark Brown wrote:
>>> On Thu, Jul 13, 2017 at 11:18:11AM -0700, Joe Perches wrote:
>>>> I don't it's better.
>>>> It's not that confusing if the 0/n patch cover letter is cc'd
>>>> to all the appropriate mailing lists and all the [1..n]/n
>>>> patches are sent with in-reply-to of the cover letter and
>>>> send to the maintainers and appropriate mailing lists.
>>> With large serieses like Gustavo is sending the CC list can easily hit
>>> the points where mailing lists start blocking it, and the individual
>>> pathces really do need to go to the relevant people so they have sight
>>> of them.
>> I agree and that's what I wrote.
> The set of people who should have sight of the patches is wider than
> just the maintainers.
I'm running get_maintainer.pl in the following way in order to get all 
the supporters, maintainers and lists:

$ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback <file>

Thank you

-- 
Gustavo A. R. Silva
