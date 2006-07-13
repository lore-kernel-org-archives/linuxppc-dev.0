Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id BB3D867BA9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 07:27:37 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: bwarren@qstreams.com
Subject: Re: Knowing kernel module load address (insmod hasn't -m)
Date: Thu, 13 Jul 2006 23:27:58 +0200
References: <200607132238.11177.antonio.dibacco@aruba.it>
	<1152824648.5238.12.camel@saruman.qstreams.net>
In-Reply-To: <1152824648.5238.12.camel@saruman.qstreams.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607132327.58708.antonio.dibacco@aruba.it>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> cat /proc/modules
>
> If you want more detailed information about a module (locations
> of .text, .data, .bss etc), enable CONFIG_KALLSYMS in your kernel and

Does this option exist in kernel 2.4 too? I didn't find it!

Thank you,
Antonio.
