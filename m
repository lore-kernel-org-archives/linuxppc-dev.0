Return-Path: <severo.ricardo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id DE9D2DDFCB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 03:50:40 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so69308pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 08:50:38 -0800 (PST)
Message-ID: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
Date: Wed, 13 Feb 2008 14:50:37 -0200
From: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: TLB Miss booting linux kernel on ppc 405
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I'm using kernel 2.6.24 and when it comes to line 826 on the file
arch/ppc/kernel/head_4xx.S it gives a TLB Miss.

arch/ppc/kernel/head_4xx.S
823 start_here:
824
825         /* ptr to current */
826         lis    r2,init_task@h
827         ori    r2,r2,init_task@l

It seems to have a problem initializing the MMU.

What I could do to solve this?

Thanks,

-- 
Ricardo Ayres Severo <severo.ricardo@gmail.com>
