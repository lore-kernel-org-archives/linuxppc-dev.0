Return-Path: <robin@india.tejasnetworks.com>
Received: from pop-mail.india.tejasnetworks.com (smtp.india.tejasnetworks.com
	[164.164.94.83]) by ozlabs.org (Postfix) with SMTP id EEA642BF17
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jan 2005 00:29:38 +1100 (EST)
Message-ID: <41DC9568.6090106@india.tejasnetworks.com>
Date: Thu, 06 Jan 2005 07:03:28 +0530
From: Robin <robin@india.tejasnetworks.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050106121238.BB99AC108D@atlas.denx.de>
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

Thanks for your response..

I have tried with the standard linux date too. That too doesnt seem to 
consider
timezone variable that has been set. Can you give me a way for setting 
timezone
for southern hemisphere countries?? The busybox code uses strftime function.
But that does not seem to consider TZ variable...

Regards,
Robin

Wolfgang Denk wrote:

>In message <4229EDFB.2040402@india.tejasnetworks.com> you wrote:
>
>>I am trying to find a way of setting TZ environment variable with DST
>>
>
>Your subject is misleading. Timezone handling is a user space  issue.
>It has nothing to do with the kernel verison.
>
>>I am using 2.4.20 linux kernel from denx.I am running date command from
>>
>
>This has nothing to do with your problems.
>
>>busybox version 0.6 which in is using strftime. The processor is ppc860T.
>>
>
>BB 0.6 ? AFAICT there is no such version. Do you mean  busybox-0.60.5 ?
>
>This is awfully old. Maybe  you  should  try  running  an  up-to-date
>version  of  busybox  first?  If  this doesn;'t work, please consider
>using the real GNU date  command.  You  should  understand  that  the
>busybox  tools  only provide limited functionality, so fancy features
>like complex timezone support may not be available.
>
>Best regards,
>
>Wolfgang Denk
>
