Return-Path: <neko@genesi-usa.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by ozlabs.org (Postfix) with ESMTP id 59DE2DE202
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:02:12 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so5873160fkz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 14:02:10 -0700 (PDT)
Message-ID: <47EAB9CC.7060002@genesi-usa.com>
Date: Wed, 26 Mar 2008 21:02:04 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: [RESEND][POWERPC] mpc5200: Amalgamated dts fixes and updates
References: <47E2723D.1090101@grandegger.com>
	<47E281B6.20702@denx.de>	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>	<47E2FC3E.1020705@semihalf.com>	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>	<20080321235633.GB345@frozen.semihalf.com>	<fa686aa40803212014ne560615sfcdef542d59eb6cb@mail.gmail.com>
	<20080326194526.GA17424@frozen.semihalf.com>
In-Reply-To: <20080326194526.GA17424@frozen.semihalf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bartlomiej Sieka wrote:
> +
> +			phy0:ethernet-phy@0 {
> +				device_type = "ethernet-phy";
> +				reg = <0>;
> +			};

What's the parsing of this pan out to? What does it mean?

Having colons in device names is totally contrary to OF device naming
spec. Does the part after the colon have a special meaning to the DTC?

I also was under the impression that device_type was invalid in a DTS
file, have we changed our minds again?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
