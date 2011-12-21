Return-Path: <bill4carson@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6EEE6B6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 13:11:53 +1100 (EST)
Received: by yhjj56 with SMTP id j56so5020422yhj.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 18:11:49 -0800 (PST)
Message-ID: <4EF14156.3040509@gmail.com>
Date: Wed, 21 Dec 2011 10:15:50 +0800
From: bill4carson <bill4carson@gmail.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Copy machine descriptor after probe succeed
References: <1324372127-8552-1-git-send-email-bill4carson@gmail.com>	<1324372127-8552-2-git-send-email-bill4carson@gmail.com>
 <20111220211751.7dcff65ecfb1c5eaf022070d@canb.auug.org.au>
In-Reply-To: <20111220211751.7dcff65ecfb1c5eaf022070d@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2011年12月20日 18:17, Stephen Rothwell wrote:
> Hi Bill,
>
> On Tue, 20 Dec 2011 17:08:47 +0800 bill4carson@gmail.com wrote:
>> From: Bill Carson<bill4carson@gmail.com>
>>
>> It make more sense to copy machine descriptor AFTER machine probe return
>> succeed.
> Some of the platform's probe routines modify the ppc_md structure and so
> assume that it is has been popluated before the probe routine is called.
>
I didn't see the whole picture before :(
thanks for your point.


-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
