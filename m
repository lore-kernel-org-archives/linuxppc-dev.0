Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2FA8DE144
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 19:30:26 +1000 (EST)
Message-ID: <48DB5A2F.4030502@linux.net.cn>
Date: Thu, 25 Sep 2008 17:30:23 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: Leo Li <pku.leo@gmail.com>
Subject: Re: [PATCH] pata_platform struct resource signness fix
References: <20080925083622.GA2701@debian>
	<2a27d3730809250212q4092d0bbyc6aa68723ff22c29@mail.gmail.com>
In-Reply-To: <2a27d3730809250212q4092d0bbyc6aa68723ff22c29@mail.gmail.com>
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

As I said, I didn't spend much time on the issue, so I don't know which patch
is better. (But I do think the patch to pata_of_platform.c is better ATM).

AFAIK, powerpc is the only consumer of pata_of_platform.c, so I think this list
is better for discussion.

I should cc: Anton Vorontsov <avorontsov@ru.mvista.com> but last time I cc:
him I got bounced.

Leo Li wrote:
> On Thu, Sep 25, 2008 at 4:36 PM, Wang Jian <lark@linux.net.cn> wrote:
>> Hi,
>>
>> This patch is to pata_platform.c but at this time, it's powerpc specific
>> because it can only be triggerred using openfirmware, so I post the patch
>> here. The patch is against 2.6.26-rc8.
> 
> Powerpc isn't the only arch to use openfirmware.  Anyway, you have to
> cc linux-ide@vger.kernel.org if you want the patch to be merged.
> 
> - Leo
> 
> 
