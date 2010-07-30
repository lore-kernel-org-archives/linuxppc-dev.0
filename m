Return-Path: <fkan@apm.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
	by ozlabs.org (Postfix) with SMTP id 598DB1007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 10:15:01 +1000 (EST)
Received: by yxe42 with SMTP id 42so535450yxe.41
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 17:15:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100726231616.GA25342@suse.de>
References: <12801701823001-git-send-email-fchen@apm.com>
	<20100726213704.GA16268@suse.de>
	<4C4E0449.2070108@caviumnetworks.com>
	<20100726220513.GA9671@suse.de> <20100726220809.GA9784@suse.de>
	<AANLkTinbTnrr9DCiSgKngAjaak=U0qDYcCxbNZR4Nm3D@mail.gmail.com>
	<20100726231616.GA25342@suse.de>
Date: Thu, 29 Jul 2010 17:14:59 -0700
Message-ID: <AANLkTikDpxcOj=TgD5697HOzPOanECGd4G6QaXZmoS98@mail.gmail.com>
Subject: Re: [PATCH 1/2 v1.03] Add support for DWC OTG HCD function.
From: Feng Kan <fkan@apm.com>
To: Greg KH <gregkh@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: linux-usb@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>,
	linuxppc-dev@ozlabs.org, Mark Miesfeld <mmiesfeld@apm.com>,
	Ted Chan <tchan@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Greg:

We will change to a BSD 3 clause license header. Our legal counsel is
talking to Synopsis to make this change. We will resubmit once this
is in place. Please let me know if you have any additional concerns.

Feng Kan
Applied Micro

On Mon, Jul 26, 2010 at 4:16 PM, Greg KH <gregkh@suse.de> wrote:
> On Mon, Jul 26, 2010 at 04:05:49PM -0700, Feng Kan wrote:
>> Hi Greg:
>>
>> We are having our legal revisit this again. What would you advise us
>> to do at this point?
>
> I thought I was very clear below as to what is needed.
>
>> Disclose the agreement or have someone with legal authority reply this
>> thread.
>
> Neither will resolve the end issue, right?
>
>> Perhaps something in the header that states Applied Micro verified
>> with Synopsys to use this code for GPL purpose.
>
> No, that will just make it messier. =C2=A0Someone needs to delete all of =
the
> mess in the file, put the proper license information for what the code
> is being licensed under (whatever it is), and provide a signed-off-by
> from a person from Synopsys and APM that can speak for the company that
> they agree that the code can properly be placed into the Linux kernel.
>
> thanks,
>
> greg k-h
>



--=20
Feng Kan
