Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99B10DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 00:07:15 +1100 (EST)
Message-ID: <45ACC1B4.4050904@cambridgebroadband.com>
Date: Tue, 16 Jan 2007 12:14:44 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: onetarget@sina.com, linuxppc-embedded@ozlabs.org
Subject: Re: fcc_enet.c and set_multicast_list
References: <20070115090236.93444.qmail@mail3-101.sinamail.sina.com.cn>
In-Reply-To: <20070115090236.93444.qmail@mail3-101.sinamail.sina.com.cn>
Content-Type: text/plain; charset=GB2312
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This has been discussed several times before on this list:

 http://www.google.co.uk/search?q=set_multicast_list+linuxppc-embedded

I know that commenting out the return makes promiscuous mode work.  Not
sure about multicast addresses though.

Alex

onetarget@sina.com wrote:
> Dear all,
>     I am just using ELDK3.1.1, and MPC8270 board, and I found there is a 
> "return;" in arch/ppc/8260_io/fcc_enet.c:set_multicast_list(), what it 
> means? Does it mean that we can not use set_multicast_list() as we want?
>     Thank you,
> 
>     W.target
>     Jan-15-2007
> 
> 
> -------------------------------------------------------------------
> 惠普商用台式机dc5750,高性能，低功耗！( 
> http://ad4.sina.com.cn/sina/limeng3/mail_zhuiyu/2006/mail_zhuiyu_20061225.html 
> )
> 
> ===================================================================
> 注册新浪2G免费邮箱（ http://mail.sina.com.cn/chooseMode.html ）
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
