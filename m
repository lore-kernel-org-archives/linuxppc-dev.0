Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 44EBB67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 17:57:10 +1100 (EST)
Message-ID: <422FEFBE.4070903@varma-el.com>
Date: Thu, 10 Mar 2005 09:57:02 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>,
	Kumar Gala <kumar.gala@freescale.com>
References: <422EEA20.4050907@varma-el.com>	<d32d7ad858d3660f9d7fdf33003ca4cc@freescale.com>
	<422F34F9.1050607@varma-el.com> <422F4284.1050806@246tNt.com>
	<422F486A.2080104@varma-el.com> <422F534A.1020107@246tNt.com>
In-Reply-To: <422F534A.1020107@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: paulus@samba.org, linuxppc-embedded@ozlabs.org
Subject: Re: RFC/Commit: New ocp id for CANbus devs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:
> 
>> Sylvain, but what I wish now - only single number
>> (until driver will done).
> 
> If you only need a temporary ocp ID, just fix it youself in your local 
> tree, no need to try to push that upstream.

I already use it as temp, but I don't want pitfalls in future (when
smb. take this number).

Also, since CAN ocp present not only in MPC5200, but, AFAIK, in another 
chips too, IMHO, it must be well known constant id.

Regards
Andrey
