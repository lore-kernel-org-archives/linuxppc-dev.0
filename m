Return-Path: <dbaryshkov@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 61A341007D5
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 18:41:24 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id l26so1414166fgb.3
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 01:41:21 -0700 (PDT)
Message-ID: <4C19DFB6.6040805@gmail.com>
Date: Thu, 17 Jun 2010 12:41:26 +0400
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] lite5200: fix ethernet phy address
References: <1276154181-25534-1-git-send-email-dbaryshkov__1637.54533646188$1276154215$gmane$org@gmail.com>
	<hv8ua6$uq0$1@dough.gmane.org>
	<AANLkTilDO4Q_pXHux71Cr34EQsso-8kAd1ce7q2ATrCd@mail.gmail.com>
In-Reply-To: <AANLkTilDO4Q_pXHux71Cr34EQsso-8kAd1ce7q2ATrCd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16.06.2010 22:25, Grant Likely wrote:
> On Tue, Jun 15, 2010 at 4:19 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com>  wrote:
>> Dmitry Eremin-Solenikov wrote:
>>
>>> According to my schematics, on Lite5200 board ethernet phy uses address
>>> 0 (all ADDR lines are pulled down). With this change I can talk to
>>> onboard phy (LXT971) and correctly use autonegotiation.
>>
>> What about this patch?
>
> It was included in my merge req to Linus yesterday.

Yes. This mail was sent a minute before you've sent poll request to Linus :)

Sorry for the noise.

-- 
With best wishes
Dmitry
