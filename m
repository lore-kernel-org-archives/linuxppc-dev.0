Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id AEAB6DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 11:21:08 +1100 (EST)
Message-ID: <47992B52.3020706@windriver.com>
Date: Thu, 24 Jan 2008 19:20:34 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/10] CPM2: Make support for the CPM2 optional on 8560
	based	boards
References: <12012180922447-git-send-email-paul.gortmaker@windriver.com>	<12012180943940-git-send-email-paul.gortmaker@windriver.com>	<12012180944056-git-send-email-paul.gortmaker@windriver.com>
	<12012180951674-git-send-email-paul.gortmaker@windriver.com>
	<47992A27.1070409@freescale.com>
In-Reply-To: <47992A27.1070409@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Paul Gortmaker wrote:
>> @@ -41,7 +42,7 @@ config MPC85xx_DS
>>  config SBC8560
>>      bool "Wind River SBC8560"
>>      select DEFAULT_UIMAGE
>> -    select PPC_CPM_NEW_BINDING
>> +    select PPC_CPM_NEW_BINDING if CPM2
>>      help
>>        This option enables support for the Wind River SBC8560 board
>
> Setting PPC_CPM_NEW_BINGING should be harmless if CPM2 isn't set.  
> Looks good otherwise.
>
> -Scott
>

Yes, it should be harmless;  I was just thinking of it
from the point of view of less chatter in the .config
file (yes, you could say that is a lost cause...)

P.
