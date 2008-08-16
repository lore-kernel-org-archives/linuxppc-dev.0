Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 18900DDEE9
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Aug 2008 02:40:14 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KUOp0-0005tL-MO
	for linuxppc-dev@ozlabs.org; Sat, 16 Aug 2008 09:40:10 -0700
Message-ID: <19012925.post@talk.nabble.com>
Date: Sat, 16 Aug 2008 09:40:10 -0700 (PDT)
From: wangyanlong <killyouatonce@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: use plb_tft_cntlr_ref_d meet the problem
In-Reply-To: <12503243.2535401218648358862.JavaMail.nabble@isper.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <12503243.2535401218648358862.JavaMail.nabble@isper.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It is work now , enable the plb_ddr 's burst mode ,thanks

wangyanlong wrote:
>=20
>      Has anybody add the plb_tft_cntlr_ref  to the desgin ? I add
> the pcores whcih copy from slideshow which is a reference desgin.
>>
>>     Something is  wrong. I show the  image in my design , the
>> plb_tft_cntlr_ref  ip core is works ,but it  not work very well . The
>> image shows in the lcd is fuzzy. The problem is not the software ,
>> beacause it use some software as reference desgin.
>      The image in the reference desgin is clear=EF=BC=8Cbut it fuzzy in m=
y design
> .Why ???
>  Many Thanks
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20

--=20
View this message in context: http://www.nabble.com/use-plb_tft_cntlr_ref_d=
-meet-the-problem-tp18967613p19012925.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
