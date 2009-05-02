Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC309DDDB2
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 10:05:14 +1000 (EST)
Message-ID: <49FB8E32.1050100@garzik.org>
Date: Fri, 01 May 2009 20:05:06 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2] Added support for Designware SATA controller driver
References: <1241211767-32697-1-git-send-email-fkan@amcc.com>
	<20090501232040.3E59283420E8@gemini.denx.de>
In-Reply-To: <20090501232040.3E59283420E8@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mark Miesfeld <miesfeld@gmail.com>, linuxppc-dev@ozlabs.org,
	Feng Kan <fkan@amcc.com>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> Dear Feng Kan,
> 
> In message <1241211767-32697-1-git-send-email-fkan@amcc.com> you wrote:
>> This adds support for the Designware SATA controller.
>>
>> Signed-off-by: Feng Kan <fkan@amcc.com>
>> Signed-off-by: Mark Miesfeld <miesfeld@gmail.com>
>> ---
>>  drivers/ata/Kconfig    |   10 +
>>  drivers/ata/Makefile   |    1 +
>>  drivers/ata/sata_dwc.c | 2053 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 2064 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/ata/sata_dwc.c
> 
> ...
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@amcc.com>");
>> +MODULE_DESCRIPTION("DesignWare Cores SATA controller low lever driver");
> ------------------------------------------------------------^^^^^
> 
> Guess that's a typo?

heh


> Hmm... that's 2000+ lines of code in a single file. Maybe this should
> be split?

A single file is just fine.

	Jeff
