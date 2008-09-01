Return-Path: <vancasperz@yahoo.com.cn>
Received: from n74.bullet.mail.sp1.yahoo.com (n74.bullet.mail.sp1.yahoo.com
	[98.136.44.186]) by ozlabs.org (Postfix) with SMTP id D6E4DDE0F0
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 17:50:41 +1000 (EST)
Subject: Re: [Evolves!] Why does one "stw" fail with address translation
	disabled in PPC405EP?
From: Zhou Rui <vancasperz@yahoo.com.cn>
To: benh@kernel.crashing.org
In-Reply-To: <1220253463.13010.40.camel@pasglop>
References: <1219429635.8882.22.camel@zr.gii.upv.es>
	<20080822184213.GA24526@yoda.jdub.homelinux.org>
	<1219479992.7565.17.camel@localhost>
	<20080824185547.94A0724899@gemini.denx.de>
	<1219691805.6735.63.camel@zr.gii.upv.es>
	<1220183410.6750.56.camel@zr.gii.upv.es>
	<1220247721.13010.33.camel@pasglop>
	<1220253721.6764.9.camel@zr.gii.upv.es>
	<1220253463.13010.40.camel@pasglop>
Content-Type: text/plain
Date: Mon, 01 Sep 2008 10:19:41 +0200
Message-Id: <1220257181.6764.19.camel@zr.gii.upv.es>
Mime-Version: 1.0
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Paul spotted today that you are actually trying to use __pa() on
> addresses returned from vmalloc, that will not work. Those are virtual
> addresses in a non-linear mapping, _pa() only works on the linear
> mapping.
> 
> Ben.

Oh, do you mean the addresses vmalloc() returns are non-linear mapping?
So if I use vmalloc(), how to translate the virtual addresses to
physical ones?
And does kmalloc() return addresses linear mapping?

Thank you!

Best Wishes

Zhou Rui
2008-09-01

> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
