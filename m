Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (unknown [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 086A1B6F29
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 10:49:17 +1000 (EST)
Message-ID: <4C23FD0A.6010805@mlbassoc.com>
Date: Thu, 24 Jun 2010 18:49:14 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com> <4C20D162.2020302@freescale.com>
	<4C23CC38.9040108@freescale.com>
In-Reply-To: <4C23CC38.9040108@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2010 03:20 PM, Timur Tabi wrote:
> Timur Tabi wrote:
>> I'd say that there are plenty of unknown issues with this driver/hardware.
>> For some reason, QE UART is just unreliable.  I've had several people try to
>> use the QE for UART, and almost everyone has problems with it.
>
> I finally got in touch with one of the other development teams, and they
> said that they got QE UART working with the 8569 and the P1021.  The
> reference board we make with the 8568 does not have QE pinned to the UART,
> so they didn't try to support that.

What about 8358?  I'm really stuck here - Rx seems to work,
but Tx is totally dead...

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
