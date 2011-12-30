Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id AD8C8B6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Dec 2011 05:28:15 +1100 (EST)
To: smitha.vanga@wipro.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Mac address in the DTS file
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <40631E9A2581F14BA60888C87A76A1FE01C6BB@HYD-MKD-MBX4.wipro.com>
References: <40631E9A2581F14BA60888C87A76A1FE01C6BB@HYD-MKD-MBX4.wipro.com>
Date: Fri, 30 Dec 2011 19:28:06 +0100
Message-Id: <20111230182806.21CF61931810@gemini.denx.de>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear smitha.vanga@wipro.com,

In message <40631E9A2581F14BA60888C87A76A1FE01C6BB@HYD-MKD-MBX4.wipro.com> you wrote:
>  
> In my DTS file for mpc8247 I have defined the ether MAC in the node as below.

On a MPC82xx there is a chance that you are using U-Boot as boot
loader...

> How do I change the MAC address. If different targets boards are

U-Boot can store (it the environment variables) MAC addresses and
update the DT with this information.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Beware of bugs in the above code; I have only proved it correct, not
tried it."                                             - Donald Knuth
