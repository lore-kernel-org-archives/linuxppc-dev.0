Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CC9F685CB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Oct 2005 18:59:40 +1000 (EST)
Received: from zambia.cambridgebroadband.com (cbluk-gw0.cambridgebroadband.com
	[217.204.121.82])
	by cambridgebroadband.com (8.12.8/8.12.8) with SMTP id j9Q8xZ9a010436
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Oct 2005 09:59:35 +0100
Date: Wed, 26 Oct 2005 09:59:35 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20051026095935.66fe98d8.ajz@cambridgebroadband.com>
In-Reply-To: <F795765B112E7344AF36AA91127964158496CE@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA91127964158496CE@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: compact flash driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 25 Oct 2005 11:44:08 -0700
"Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com> wrote:

> Hello All,
> Are there any compact flash driver supported for Linux 2.6? If there
> is where can i get the source code.
> Thanks,
> Bizhan
> 


I think that CF cards just get treated the same as any other IDE
disk by linux.  No special driver needed.
