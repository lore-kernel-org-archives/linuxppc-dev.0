Return-Path: <robin@india.tejasnetworks.com>
Received: from pop-mail.india.tejasnetworks.com (smtp.india.tejasnetworks.com
	[164.164.94.83]) by ozlabs.org (Postfix) with SMTP id E0CF72BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jan 2005 18:26:51 +1100 (EST)
Message-ID: <41DE3A2A.3050105@india.tejasnetworks.com>
Date: Fri, 07 Jan 2005 12:58:42 +0530
From: Robin <robin@india.tejasnetworks.com>
MIME-Version: 1.0
To: Marius Groeger <mgroeger@sysgo.com>
References: <20050106121238.BB99AC108D@atlas.denx.de>
	<41DC9568.6090106@india.tejasnetworks.com>
	<Pine.LNX.4.61.0501061450190.4945@mag.sysgo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: TZ variable setting for denx 2.4.20
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi
Thanx for your response. I am setting TZ variable as
given in the documentation.
   export TZ="xxx5:30yyy4:30,M10.1.1,M2.1.1"
Its working fine till Dec 31 23:59:59GMT. On Jan 01 00:00:00,
 its not taking DST into account at all.

Please tell me some way of setting it across an year boundary.
Thanks,
Robin


Marius Groeger wrote:

> Robin,
>
> On Thu, 6 Jan 2005, Robin wrote:
>
>> I have tried with the standard linux date too. That too doesnt seem 
>> to consider timezone variable that has been set. Can you give me a 
>> way for setting timezone for southern hemisphere countries?? The 
>> busybox code uses strftime function. But that does not seem to 
>> consider TZ variable...
>
>
> You should read up on how glibc handles all that timezone stuff:
>
>   sh# info libc "TZ Variable"
>
> Most notably, make sure you /etc/localtime is set up correctly. There 
> is also a tool (script) called tzselect which may be helpful for you.
>
> Note I'm not exactly an expert on this, I'm just giving pointers...
>
> Regards,
> Marius
>
