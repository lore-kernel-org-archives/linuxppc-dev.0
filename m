Return-Path: <matvejchikov@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 22B93DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jun 2008 21:52:13 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so777548ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 07 Jun 2008 04:52:11 -0700 (PDT)
Message-ID: <8496f91a0806070452v33543e3cv18a2f6c5468e3565@mail.gmail.com>
Date: Sat, 7 Jun 2008 15:52:11 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "Detlev Zundel" <dzu@denx.de>
Subject: Re: No console output when booting linux from uboot
In-Reply-To: <m28wxh4i58.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <A9D89E0D76AFF24B9441851F2AC72D7203B7D468@BANMLVEM05.e2k.ad.ge.com>
	<m2hcc988n9.fsf@ohwell.denx.de>
	<A9D89E0D76AFF24B9441851F2AC72D7203BCB942@BANMLVEM05.e2k.ad.ge.com>
	<m2od6g6jxv.fsf@ohwell.denx.de>
	<A9D89E0D76AFF24B9441851F2AC72D7203C0DAAA@BANMLVEM05.e2k.ad.ge.com>
	<m28wxh4i58.fsf@ohwell.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

May be console=ttyCPM0,115200 helps?

2008/6/7 Detlev Zundel <dzu@denx.de>:
> Hi Mike,
>
>> Sorry for the confusing. I just figured out my problem is not for the
>> Uboot version...
>>
>> As you suggested, I debuged the hw action related to serial driver
>> today. I add the "console=ttyS2" in my uboot bootargs and corrected some
>> part, but still no output yet. Is there other factors will affect the
>> console output, except the serial driver?
>
> Actually not that I can think of.  Depending on your driver, maybe the
> default baud rate is not correct?  Did you try a "console=ttyS2,115200"
> for example?
>
> Cheers
>  Detlev
>
> --
> DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
