Return-Path: <mikey@ozlabs.org>
To: michael@ellerman.id.au
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Make RTAS console init generic 
In-reply-to: <1155786333.10665.3.camel@localhost.localdomain> 
References: <20060816194225.C9F1F67B32@ozlabs.org>
	<1155780267.6910.3.camel@localhost.localdomain>
	<20060817032723.25A2767B6D@ozlabs.org>
	<1155786333.10665.3.camel@localhost.localdomain>
Date: Wed, 16 Aug 2006 23:02:30 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060817040236.19D3E67B70@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yeah, but that then turns on CONFIG_UDBG_RTAS_CONSOLE also. I guess
> you guys want to be able to turn on the later without the former, so
> fair enough.

Yeap.  

Mikey
