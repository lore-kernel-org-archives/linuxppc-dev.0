Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id EB18267A39
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Mar 2006 06:49:49 +1100 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: kmod: /sbin/modprobe char-major-4 failed
Date: Sun, 5 Mar 2006 20:52:46 +0100
References: <20060303141742.21257.qmail@mx1.aruba.it>
In-Reply-To: <20060303141742.21257.qmail@mx1.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603052052.46533.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 03 March 2006 15:17, antonio.dibacco wrote:
> Why should the kernel try to load this char-major-4? What should I
> configure in  the kernel to have this module not loadable but included in
> the kernel?
>
> Bye,
> Antonio.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


Simply you missed modprobe!!!!
