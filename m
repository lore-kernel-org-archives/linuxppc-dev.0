Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1E1ADDF61
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 07:39:39 +1000 (EST)
In-Reply-To: <0E974259-7988-4E3F-81F6-3FDEA01BAC9A@kernel.crashing.org>
References: <20080606143347.B35CC247FE@gemini.denx.de>
	<A005B9E2-9A1D-4190-AB00-A7C880E4DBDB@kernel.crashing.org>
	<1212766264.6788.4.camel@ld0161-tx32>
	<0E974259-7988-4E3F-81F6-3FDEA01BAC9A@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7bd636c4a22d485c857961e093468bb8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Default flats for running dtc from kernel build
Date: Fri, 6 Jun 2008 23:39:15 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> DTS_FLAGS	?= -P 0x1000
>
> 1k seems like more than enough default padding.

Yes.  So why specify 4kB?

/me hides


Segher
