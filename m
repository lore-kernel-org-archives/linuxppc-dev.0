Return-Path: <wmb@firmworks.com>
Message-ID: <4CE1B18F.2030906@firmworks.com>
Date: Mon, 15 Nov 2010 12:17:51 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] powerpc: pcm030/032: add pagesize to dts
References: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
	<1289841916-3825-2-git-send-email-w.sang@pengutronix.de>
	<20101115173250.GA22104@oksana.dev.rtsoft.ru>
	<4CE1A0E4.5030505@firmworks.com>
	<20101115212432.GA17754@oksana.dev.rtsoft.ru>
	<AANLkTi=H_zONah7YuKSffkGrSiGa+7-LSbXE+qO=86Zj@mail.gmail.com>
In-Reply-To: <AANLkTi=H_zONah7YuKSffkGrSiGa+7-LSbXE+qO=86Zj@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In general I think it's better to report parameter values directly, 
instead of inferring them from manufacturer and part numbers.  That way 
you at least have a fighting chance of avoiding a kernel upgrade when a 
part changes.

Of course, that only works when the device tree is exported from the 
boot firmware instead of having to carry the device tree inside the kernel.
