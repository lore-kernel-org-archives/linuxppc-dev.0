Return-Path: <Regis.Odeye@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[213.179.130.140]) by ozlabs.org (Postfix) with ESMTP id DB8D0DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 01:19:17 +1100 (EST)
Message-ID: <48FF364E.9070701@kontron.com>
Date: Wed, 22 Oct 2008 16:18:54 +0200
From: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Extended Addressing Mode
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<48FF2DDE.9060301@genesi-usa.com>
In-Reply-To: <48FF2DDE.9060301@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
>
> I'd also be interested in any work done to enable non-contiguous 
> memory areas. Reading the docs for the MPC8641D though I am not sure 
> you can set up LAWs for it?
>
> One thing I wanted to try was installing 4GB in a system and 
> "overlapping" IO (since there is very little of it on a stock 
> MPC8641DHPCN) in the top ~256MB-512MB, but I am fairly sure this is 
> NOT supported because of the way the LAWs work, and also the alignment 
> of the LAWs means it is not fine enough granularity to map between 2GB 
> and 4GB into a window (you can have 2GB or 4GB but not some more 
> arbitrary value?)
>
On my point of view, LAWs sizes are power of 2 and should be aligned to 
the window size. But there is 10 LAWs you can combine to achieve quite a 
lot of different mappings.
Regards.

-- 
Régis ODEYE

Kontron Modular Computers SA
150, rue M. Berthelot / ZI Toulon Est / BP 244 / Fr 83078 TOULON Cedex 9
Phone: (33) 4 98 16 34 86           Fax: (33) 4 98 16 34 01
E-mail: regis.odeye@kontron.com  Web : www.kontron.com
