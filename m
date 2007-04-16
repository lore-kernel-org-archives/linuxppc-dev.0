Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C2E7CDDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 02:49:24 +1000 (EST)
Message-ID: <4623AA1A.8050407@ru.mvista.com>
Date: Mon, 16 Apr 2007 20:53:46 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] Xilinx SystemACE device driver
References: <1176600194262-git-send-email-grant.likely@secretlab.ca>	
	<4623A523.3040705@ru.mvista.com>
	<528646bc0704160933o76861f6cqaeac768415f8adb8@mail.gmail.com>
In-Reply-To: <528646bc0704160933o76861f6cqaeac768415f8adb8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Stefan Roese <sr@denx.de>,
	Rick Moleres <Rick.Moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 4/16/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
>> Hi Grant,
>>
>> Grant Likely wrote:
>> > Add support for block device access to the Xilinx SystemACE Compact
>> > flash interface
>>
>> Does the driver support 8-bit bus_width?
>>
>> Just gave the driver a try on ML300, and my first attempt failed.
>> Wonder if it's me having done something wrong, or something the driver 
>> doesn't
>> handle yet.
> 
> Doesn't handle it yet, you'll need to add 8-bit access macros to the
> top of the file.

OK. Thanks!
Will try that.

Thanks,
Andrei

> Cheers,
> g.
> 
