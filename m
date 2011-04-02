Return-Path: <sshtylyov@mvista.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F92BB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 11:03:16 +1100 (EST)
Received: by wwi36 with SMTP id 36so3823390wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Apr 2011 17:03:11 -0700 (PDT)
Message-ID: <4D966760.7050103@ru.mvista.com>
Date: Sat, 02 Apr 2011 04:01:36 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH v11 09/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
References: <1301684736-17647-1-git-send-email-tmarri@apm.com>
	<4D962588.9050800@ru.mvista.com>
	<de7f66c2a03ec9fc17d30acdb23f35c6@mail.gmail.com>
In-Reply-To: <de7f66c2a03ec9fc17d30acdb23f35c6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, greg@kroah.com,
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

On 02-04-2011 1:23, Tirumala Marri wrote:

>>> +++ b/drivers/Makefile
>>> @@ -65,6 +65,7 @@ obj-$(CONFIG_PARIDE) 		+= block/paride/
>>>   obj-$(CONFIG_TC)		+= tc/
>>>   obj-$(CONFIG_UWB)		+= uwb/
>>>   obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
>>> +obj-$(CONFIG_USB_DWC_OTG)	+= usb/otg/dwc/

>>      Haven't we recently agreed with Greg on drivers/usb/dwc/?

> [marri] I did not see Greg's response saying yes. I thought we are still
> sticking with usb/otg/dwc.

    Well, it was Greg's suggsestion, it was me who said "yes". :-)

WBR, Sergei
