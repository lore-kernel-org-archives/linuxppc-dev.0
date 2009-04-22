Return-Path: <vows_siu@yahoo.com.hk>
Received: from smtp128.mail.sg1.yahoo.com (smtp128.mail.sg1.yahoo.com
	[124.108.123.199]) by ozlabs.org (Postfix) with SMTP id 989F1DE04E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:42:31 +1000 (EST)
Message-Id: <63EE0043-14E3-4FE7-8483-3D24FA12A33E@yahoo.com.hk>
From: Roy Siu <vows_siu@yahoo.com.hk>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20090422181059.7510A83420E8@gemini.denx.de>
Content-Type: text/plain; charset=BIG5; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [OT] Lite5200B w/ nfs root hangs after some time
Date: Thu, 23 Apr 2009 07:35:34 +0800
References: <1240422181.5492.0@antares>
	<20090422181059.7510A83420E8@gemini.denx.de>
Cc: =?UTF-8?Q?Albrecht_Dre=C3=9F?= <albrecht.dress@arcor.de>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

good try for the expr., platform.

=A6b 2009=A6~4=A4=EB23=A4=E9 =A4W=A4=C82:10 =AE=C9=A1A Wolfgang Denk =
=BCg=A8=EC=A1G

> Dear Albrecht =3D?iso-8859-1?b?RHJl3w=3D=3D?=3D,
>
> In message <1240422181.5492.0@antares> you wrote:
>>
>> this question is maybe off-topic on this list...
>
> This is not off topic (actually, if you had bothered to check the
> mailing ist archives before posting, you would have known - because
> you would have found previous discussions of this issue, including the
> necessary fix).
>
>> I use the Lite5200B board with stock kernel 2.6.29, and boot with the
>
> That's known to show this problem.
>
>> [ 4912.350855] nfs: server 10.16.10.29 not responding, still trying
>
> well known symptom.
>
>> an the the system is *completely* dead, i.e. it doesn't respond to
>
> No, it is NOT completely dead, just extremely slow.
>
>> Any idea what goes wrong here, and how I could fix it?
>
> Apply this patch:
>
> http://patchwork.ozlabs.org/patch/24487/
>
> Best regards,
>
> Wolfgang Denk
>
> --=20
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> When all is said and done, more is said than done.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
