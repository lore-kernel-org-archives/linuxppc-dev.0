Return-Path: <jgarzik@pobox.com>
Message-ID: <47EDA549.3030806@pobox.com>
Date: Fri, 28 Mar 2008 22:11:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2 v2] pasemi_mac: Netpoll support
References: <20080326015625.GA23103@lixom.net>
	<20080326015801.GC23103@lixom.net>
	<20080327224007.GB17980@lixom.net>
In-Reply-To: <20080327224007.GB17980@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, ncase@xes-inc.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Add netpoll support to allow use of netconsole.
>     
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> Changed the interrupt handler arguments as found by Valentine. Will push
> through powerpc.git with Jeff's ACKs (that were already given).
> 
> 
> -Olof

ACK
