Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id AE5CEDE009
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 17:49:45 +1000 (EST)
Message-ID: <487EFA1E.8060804@coritel.it>
Date: Thu, 17 Jul 2008 09:51:58 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: how to allocate 9MB of memory in kernel ?
References: <18503022.post@talk.nabble.com>
In-Reply-To: <18503022.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Misbah khan ha scritto:
> Hi all,
> 
> I need to allocate 9 MB of memory in to the kernel space which i need to
> mmap for the application to access.
> 
> I need to know what could be the best possible way of doing the same.
> 
> Please share your experience in this regard .
> 
> Thank you in advance 
> 
> ----Misbah <><
You can use the mem option to tell to the kernel that you've got less 
ram you really have. However you can read Linux device drivers chapter 8 
"Obtaining Large Buffers" :).

Regards,

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
