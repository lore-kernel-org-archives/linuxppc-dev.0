Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E27B52C0592
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:27:56 +1100 (EST)
Message-ID: <52679692.2000900@windriver.com>
Date: Wed, 23 Oct 2013 17:27:46 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v5][PATCH 4/6] powerpc/book3e: support kgdb for kernel space
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>	
 <1371724110-8250-5-git-send-email-tiejun.chen@windriver.com>
 <1382137119.7979.916.camel@snotra.buserror.net>
In-Reply-To: <1382137119.7979.916.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/19/2013 06:58 AM, Scott Wood wrote:
> On Thu, 2013-06-20 at 18:28 +0800, Tiejun Chen wrote:
>> Currently we need to skip this for supporting KGDB.
>
> Does it need to depend on CONFIG_KGDB?  Either you've fixed the "can't
> quite save properly" part, or you haven't.

I'm not 100% sure if my change is fine to other scenarios so I have to use this 
guarantee other stuff are still safe. But if you think we can remove this 
dependent, I'm happy to do :)

Thanks,

Tiejun
