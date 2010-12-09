Return-Path: <tmarri@apm.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	by ozlabs.org (Postfix) with SMTP id E743FB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 03:52:47 +1100 (EST)
Received: by mail-qy0-f177.google.com with SMTP id 27so2275971qyk.1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Dec 2010 08:52:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D00D89B.6020208@ru.mvista.com>
References: <1291854755-25103-1-git-send-email-tmarri@apm.com>
	<4D00D89B.6020208@ru.mvista.com>
Date: Thu, 9 Dec 2010 08:52:45 -0800
Message-ID: <AANLkTimp8iF2PxApA2kXF64TM47_EeGM9BZrfi1uEVJj@mail.gmail.com>
Subject: Re: [PATCH V6 09/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget
	support
From: Tirumala Marri <tmarri@apm.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 9, 2010 at 5:24 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrot=
e:
> Hello.
>
> On 09-12-2010 3:32, tmarri@apm.com wrote:
>
>> From: Tirumala Marri<tmarri@apm.com>
>
>> Enable gadget support
>
>> Signed-off-by: Tirumala R Marri<tmarri@apm.com>
>> Signed-off-by: Fushen Chen<fchen@apm.com>
>> Signed-off-by: Mark Miesfeld<mmiesfeld@apm.com>
>
> [...]
>
>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>> index 747b0d3..b2bcc4e 100644
>> --- a/drivers/usb/gadget/Kconfig
>> +++ b/drivers/usb/gadget/Kconfig
>> @@ -365,6 +365,28 @@ config USB_GADGET_MUSB_HDRC
>
> [...]
>>
>> +config USB_OTG
>> + =A0 =A0 =A0 boolean "OTG Support"
>
> =A0 This symbol is already defined in drivers/usb/core/Kconfig.
>
> WBR, Sergei
>
Sure I will fix that.
Thx,
Marri
