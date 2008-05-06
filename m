Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by ozlabs.org (Postfix) with ESMTP id 2FDDFDDF10
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 00:39:57 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so1573578agc.0
	for <linuxppc-dev@ozlabs.org>; Tue, 06 May 2008 07:39:55 -0700 (PDT)
Message-ID: <fa686aa40805060739t32b83a67g434d0ae1595ea8e8@mail.gmail.com>
Date: Tue, 6 May 2008 08:39:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sylvain Munaut" <tnt@246tnt.com>
Subject: Re: [Fwd: fix for drivers/serial/mpc52xx_uart.c]
In-Reply-To: <481FFDF5.7060208@246tnt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <481FFDF5.7060208@246tnt.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 6, 2008 at 12:43 AM, Sylvain Munaut <tnt@246tnt.com> wrote:
> Patch, obviously correct, sent to me personally instead of the list.
>
>     Sylvain
>
> Here is a fix for the unterminated mpc52xx_uart_of_match array when CONFIG_PPC_MPC512x is not defined. Should be quite self explonary, but if not feel free to bug me about it.
>
>  Patch applies against 2.6.25 and 2.6.25.1 at least.

Already fixed in mainline; it needs to be back ported to 2.6.25.  I'll
poke GregKH

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
