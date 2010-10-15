Return-Path: <eric@eukrea.com>
Received: from 63.mail-out.ovh.net (63.mail-out.ovh.net [91.121.185.56])
	by ozlabs.org (Postfix) with SMTP id 6D869B70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Oct 2010 06:24:55 +1100 (EST)
Message-ID: <4CB8AA76.2020309@eukrea.com>
Date: Fri, 15 Oct 2010 21:24:38 +0200
From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] mxc_udc: add workaround for ENGcm09152 for i.MX35
References: <1287145858-10239-1-git-send-email-eric@eukrea.com>
	<20101015191005.GB8098@kroah.com>
In-Reply-To: <20101015191005.GB8098@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: dbrownell@users.sourceforge.net, Dinh.Nguyen@freescale.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, gregkh@suse.de,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Greg,

Le 15/10/2010 21:10, Greg KH a écrit :
> On Fri, Oct 15, 2010 at 02:30:58PM +0200, Eric Bénard wrote:
>> this patch gives the possibility to workaround bug ENGcm09152
>> on i.MX35 when the hardware workaround is also implemented on
>> the board.
>> It covers the workaround described on page 25 of the following Errata :
>> http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
>>
>> Signed-off-by: Eric Bénard<eric@eukrea.com>
>> ---
>>   arch/arm/mach-mx3/mach-cpuimx35.c |    1 +
>>   drivers/usb/gadget/fsl_mxc_udc.c  |   15 +++++++++++++++
>>   include/linux/fsl_devices.h       |    3 +++
>>   3 files changed, 19 insertions(+), 0 deletions(-)
>
> Do you want me to take this through my usb tree, or will it go through
> some other developer's tree?
>
as most of the changes are in drivers/usb that would be great if you can take it.

Thanks
Eric
