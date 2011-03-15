Return-Path: <ibr@radix50.net>
Received: from almaty.kz-easy.com (almaty.radix50.net [85.214.25.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C871B703C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 04:01:47 +1100 (EST)
Received: from alatau.radix50.net (dslb-092-074-056-154.pools.arcor-ip.net
	[92.74.56.154]) (authenticated bits=0)
	by almaty.kz-easy.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id
	p2FGstJ9031994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 17:54:56 +0100
Received: from medeu.radix50.net (root@medeu [192.168.0.3])
	by alatau.radix50.net (8.14.3/8.14.3/Debian-5) with ESMTP id
	p2FGseh0007236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 17:54:41 +0100
Received: from medeu.radix50.net (ibr@localhost [127.0.0.1])
	by medeu.radix50.net (8.14.3/8.14.3/Debian-5) with ESMTP id
	p2FGseV4013518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 17:54:40 +0100
Received: (from ibr@localhost)
	by medeu.radix50.net (8.14.3/8.14.3/Submit) id p2FGseVn013517
	for linuxppc-dev@lists.ozlabs.org; Tue, 15 Mar 2011 17:54:40 +0100
Date: Tue, 15 Mar 2011 17:54:40 +0100
From: Baurzhan Ismagulov <ibr@radix50.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?
Message-ID: <20110315165440.GC4841@radix50.net>
References: <AANLkTimJwBfz=RksRtuj3M2VQoMjj1msUb78s1H=GfJM@mail.gmail.com>
	<AANLkTikKWrEqKH-4f2aMFnVUy-xCLnvxhtjF-pKUuC6e@mail.gmail.com>
	<AANLkTinOo9tJ5=WWF2WJEZn3VwAUOa+SOYE0txNm-moM@mail.gmail.com>
	<AANLkTim6urK-1-0MXrXZPTDWifZsi+7QEH_c8S-vzWSL@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTim6urK-1-0MXrXZPTDWifZsi+7QEH_c8S-vzWSL@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2011 at 05:44:49PM +0100, nello martuscielli wrote:
> But if someone is capable (i don't have this skill) here what it
> happens reading from serial debug console untill it freezes with
> linux-2.6.36.4

What is the last kernel version working on that machine? If you have a
working kernel and can build kernels, you could try bisecting to
identify the change that led to that. Perhaps then someone could have
some ideas.

With kind regards,
-- 
Baurzhan Ismagulov
http://www.kz-easy.com/
