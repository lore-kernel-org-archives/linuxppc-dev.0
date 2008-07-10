Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 0A8F7DE3B5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 06:45:29 +1000 (EST)
Message-ID: <48767696.6090603@windriver.com>
Date: Thu, 10 Jul 2008 16:52:38 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
References: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
	<48766E4D.5060607@freescale.com>
In-Reply-To: <48766E4D.5060607@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Paul Gortmaker wrote:
>> The mpc7448hpc2 board doesn't have an alias block like
>> most of the other modern eval boards have.  We need this
>> block in order to have u-boot be able to make use of the
>> CONFIG_OF_STDOUT_VIA_ALIAS (vs. having a hard coded node)
>> in the future.
>>
>> Also remove the old, redundant chosen node.  Of all the modern
>> Freescale eval boards (incl. 83xx, 85xx, 86xx) this is the only
>> one which still has it.  Its presence also breaks with some older
>> versions of u-boot, like 1.3.1 -- which try and insert a
>> second chosen node.
>
> The chosen node is still required for output from the cuboot wrapper.

OK, so does that mean that the cuboot wrapper is explicitly
not supported for all the 83xx, 85xx, and 86xx boards?

Thanks,
Paul.

>
> -Scott
