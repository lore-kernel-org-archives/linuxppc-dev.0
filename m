Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id CC7D367B92
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 01:09:24 +1000 (EST)
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id AAA14875
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 00:05:51 +0900 (JST)
MIME-Version: 1.0
Date: Wed, 11 Oct 2006 00:09:08 +0900
Subject: Re: linux hang at a random place on booting
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: lzh <bottle715@126.com>, linuxppc-embedded@ozlabs.org
Message-ID: <JW200610110009084.9995562@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <452B88BF.000156.24582@bj126app2.126.com>
References: <452B88BF.000156.24582@bj126app2.126.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

If the u-boot version of your MPC8540ADS board is 1.0.1, it is necessary
to apply the latest u-boot1.1.4.
Moreover, if MPC8540ADS and u-boot1.1.4 are used, 2.6.17 and 2.6.18
kernels of kernel.org should be used without modification.

Yoshio Kashiwagi - Nissin Systems

>  hi,
>  i built a linux-2.6.11 kernel for mpc8540ads board。linux hang at a 
random place on booting.
> can anybody help?
> thank you!
> 
> 胆 溺 心 阻 祥 ・ 勣 ( 夕 )
> 蒸 斤 総 窃 ! 才 析 禿 海 邪 豚 寂 議 移 社 芝 村 ( 怏 夕 ) 
