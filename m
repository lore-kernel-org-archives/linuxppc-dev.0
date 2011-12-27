Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9A2DB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Dec 2011 22:07:42 +1100 (EST)
Message-ID: <4EF9A6F2.8020708@windriver.com>
Date: Tue, 27 Dec 2011 19:07:30 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: Kernel not booting when supplying boot parameter mem
References: <93CD5F41FDBC6042A6B449764F3B35CC050C9F21@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050C9F21@EU-MBX-03.mgc.mentorg.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arshad, Farrukh wrote:
> Greetings All,
> 
> I have a basic question. I have 512 MB memory. I want my kernel to use only last 128 MB of memory starting from address 0x10000000. I have configured the kernel CONFIG_PHYSICAL_START=0x10000000 and in kernel boot parameter I have set mem=128M. In this scenario my kernel is not booting and it just stuck after uncompressing it. If I do not provide mem=128M boot parameter my kernel boots fine, but in that case I can not restrict kernel to use only 128M memory. Why supplying mem=128M causing kernel to fail.
> 

Any kernel option else is configured, such as CONFIG_KERNEL_START and
CONFIG_RELOCATABLE?

Or any u-boot argument is reconfigured, such as 'bootm_low', 'bootm_mapsize' and
'bootm_size'.

Tiejun
