Return-Path: <Regis.Odeye@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[213.179.130.140]) by ozlabs.org (Postfix) with ESMTP id 76140DDF22
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 04:47:17 +1100 (EST)
Message-ID: <4981EBA1.2060902@kontron.com>
Date: Thu, 29 Jan 2009 18:47:13 +0100
From: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/example] powerpc: add the mpic global timer support
References: <Pine.LNX.4.64.0901062200550.19321@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0901062200550.19321@blarg.am.freescale.net>
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


Thanks for this.
Regards

Kumar Gala wrote:
> From: Dave Liu <daveliu@freescale.com>
>
> The mpic timer works as wake up source for power management,
> the max timer period is 336 seconds when the CCB freq is 400MHz.
>
> to setup timer, type
> echo 30 > /sys/devices/ffe00000.soc8572/ffe41100.timer/timeout
>
> before the system enter to sleep mode.
>
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> ---
>
> Posting this both as a example of timer code for Regis as well as code for
> partial review.. need to clean up a number of things.
>
> - k
>   


-- 
Régis ODEYE

Kontron Modular Computers SA
150, rue M. Berthelot / ZI Toulon Est / BP 244 / Fr 83078 TOULON Cedex 9
Phone: (33) 4 98 16 34 86           Fax: (33) 4 98 16 34 01
E-mail: regis.odeye@kontron.com  Web : www.kontron.com
