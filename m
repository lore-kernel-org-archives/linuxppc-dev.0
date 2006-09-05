Return-Path: <mikey@ozlabs.org>
To: Olof Johansson <olof@lixom.net>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [3/5] powerpc: PA6T cputable entry, PVR value 
In-reply-to: <20060905122808.36c0c88d@localhost.localdomain> 
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122808.36c0c88d@localhost.localdomain>
Date: Tue, 05 Sep 2006 13:43:26 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060905184342.872B967B95@ozlabs.org>
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

>  #define PV_630p	0x0041
>  #define PV_970MP	0x0044
>  #define PV_BE		0x0070
> +#define	PV_PA6T		0x0090
> +
>  
>  /*
>   * Number of entries in the SLB. If this ever changes we should handle

Should be a space not a tab after the #define.  Also extra new line is
not required.

Mikey "White space king" Neuling
