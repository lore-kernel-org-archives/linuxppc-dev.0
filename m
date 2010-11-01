Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id A48DDB70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 03:21:19 +1100 (EST)
Message-ID: <4CCEE8FB.2030504@neli.hopto.org>
Date: Mon, 01 Nov 2010 17:21:15 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: RapidIO: MC Exception when enumerating peer to peer connection
References: <AANLkTimS-sfqONuSJNPJy7OxO_U81qtDHe2JeioLDNVs@mail.gmail.com><4CCA9207.8050506@neli.hopto.org>
	<AANLkTikhcOMexRBVthK8Xr8VTNvDmiUDvWG+QbyzWc38@mail.gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552014B9D48@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552014B9D48@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Thomas Taranowski <tom@baringforge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bounine, Alexandre wrote:
> In the current fsl_rio implementation initialization enables ACCEPT_ALL
> mode for the port therefore you should not have problems caused by
> initial destID value. Based on your post about multiport support I think
> you are close to find a source of the problem.

Be aware that accept-all is not enabled from moment of power-on until 
boot of kernel. Depending on reset sequence you may or may not notice 
the difference.

Micha
