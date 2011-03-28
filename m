Return-Path: <sshtylyov@mvista.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1D281007EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 06:09:49 +1100 (EST)
Received: by wyg36 with SMTP id 36so2751125wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Mar 2011 12:09:45 -0700 (PDT)
Message-ID: <4D90DC8D.7020409@ru.mvista.com>
Date: Mon, 28 Mar 2011 23:07:57 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH V9 10/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
References: <1297119242-28562-1-git-send-email-tmarri@apm.com>
	<4D518B2D.3090603@ru.mvista.com>
	<5540911d2e000414054d989bbdc32f2c@mail.gmail.com>
	<4D90C78C.3050607@ru.mvista.com> <20110328183914.GA5072@kroah.com>
In-Reply-To: <20110328183914.GA5072@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Tirumala Marri <tmarri@apm.com>,
	linux-usb@vger.kernel.org, Mark Miesfeld <mmiesfeld@apm.com>,
	linuxppc-dev@lists.ozlabs.org, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

Greg KH wrote:

>>>>> +config DWC_DEVICE_ONLY
>>>>> +	bool "DWC Device Only Mode"
>>>>> +	select USB_GADGET_SELECTED
>>>>> +
>>>>> +endchoice

>>>>    So this is tri-modal driver after all... how come we place it in
>>>> drivers/usb/otg/dwc/, while the same tri-modal MUSB driver was placed in
>>>> drivers/usb/musb/?

>>    You still have quoting broken in your mailer -- I've fixed it up by hand...

>>> [Marri] Initially this was how the patch created. Greg KH, suggested to
>>> move under OTG.

>>    Well, I know that. So this was a question to Greg...

> Well, if that's not the right place to put it, Sergei, where do you
> suggest that it go?  drivers/usb/dwc/ ?

    Exactly.

> thanks,

> greg k-h

WBR, Sergei
