Return-Path: <tmbinc@elitedvb.net>
Received: from mail.multimedia-labs.de (mail.multimedia-labs.de
	[82.149.226.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.multimedia-labs.de",
	Issuer "Multimedia Labs CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A16CA67A3E
	for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2006 00:42:51 +1000 (EST)
Received: from localhost (localhost [127.0.0.172])
	by mail.multimedia-labs.de (Postfix) with ESMTP id 4C1841C80AF
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 16:42:48 +0200 (CEST)
Received: from mail.multimedia-labs.de ([127.0.0.172])
	by localhost (mail [127.0.0.172]) (amavisd-new, port 10024) with LMTP
	id 07286-03 for <linuxppc-dev@ozlabs.org>;
	Fri, 12 May 2006 16:42:46 +0200 (CEST)
Received: from xpc823.intern.randgruppe.info (e176171165.adsl.alicedsl.de
	[85.176.171.165])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.multimedia-labs.de (Postfix) with ESMTP id CA04F1C8083
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 16:42:46 +0200 (CEST)
Received: from [10.0.0.75] (unknown [10.0.0.75])
	by xpc823.intern.randgruppe.info (Postfix) with ESMTP id 613B270A38
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 16:43:53 +0200 (CEST)
Message-ID: <44649F09.2020803@elitedvb.net>
Date: Fri, 12 May 2006 16:43:21 +0200
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: 2.6 vs 2.4
References: <7cb1293c0605112351y658460a0x8b793ea12004dbfc@mail.gmail.com>
	<82ecf08e0605120729l43041aebuaef375a568700354@mail.gmail.com>
In-Reply-To: <82ecf08e0605120729l43041aebuaef375a568700354@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thiago Galesi wrote:
> Not much. This article is almost one year old. Even though some things
> do apply (like bigger footprint, etc), the kernel improved a lot on
> the months that followed that article.
> I've participated in a project that used a (somewhat patched) 2.6.10
> kernel, with soccessful results.
Can you point me to a list of changes which where done? I really like to
check if they apply to my performance problems with 2.6 kernels, i.e. if
it's worth porting the board specific changes to a newer kernel.

Felix
