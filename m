Return-Path: <linasvepstas@gmail.com>
Received: from mail-yw0-f184.google.com (mail-yw0-f184.google.com
	[209.85.211.184]) by ozlabs.org (Postfix) with ESMTP id 653B1B7CEE
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Feb 2010 04:05:48 +1100 (EST)
Received: by ywh14 with SMTP id 14so269945ywh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 09:05:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B7EBF9A.7020801@linux.vnet.ibm.com>
References: <1264789719-15591-1-git-send-email-leitao@linux.vnet.ibm.com>
	<4B6864F4.1030106@linux.vnet.ibm.com>
	<20100202180503.GL4757@pengutronix.de>
	<4B699CB9.3030605@linux.vnet.ibm.com>
	<4B7EBF9A.7020801@linux.vnet.ibm.com>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Fri, 19 Feb 2010 11:05:27 -0600
Message-ID: <3ae3aa421002190905l67e9f235he9537aeb0e56790e@mail.gmail.com>
Subject: Re: [PATCH] eeh: Fixing a bug when pci structure is null
To: Breno Leitao <leitao@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul, Breno,

Some confusion -- I've been out of the loop for a while -- I assume
its still Paul who is pushing
these patches upstream, and not Ben?  So Breno, maybe you should
resend the patch to Paul?

--linas

On 19 February 2010 10:43, Breno Leitao <leitao@linux.vnet.ibm.com> wrote:
> Hi Ben,
>
> I'd like to ask about this patch ? Should I re-submit ?
>
> Thanks,
>
> Breno Leitao wrote:
>> During a EEH recover, the pci_dev structure can be null, mainly if an
>> eeh event is detected during cpi config operation. In this case, the
>> pci_dev will not be known (and will be null) the kernel will crash
>> with the following message:
>
