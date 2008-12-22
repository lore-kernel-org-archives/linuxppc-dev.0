Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 467D9DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 11:15:07 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-174.bayarea.dialup.o1.com
	[66.81.71.174]) (authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mBM0EmCM020128
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 16:15:00 -0800 (PST)
Message-ID: <494EDB3F.4090604@hypersurf.com>
Date: Sun, 21 Dec 2008 16:11:43 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: schizophrenic G5 ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

	I have a water cooled dual 2.5 GHz G5 (Powermac7,3). It has YDL 6.0 on 
it. Using the stock YDL 2.6.23 kernel this machine "appears" to work fine.

	After finally getting it to boot under 2.6.27, it will shut itself off 
if put under any significant load. And it is doing it very quickly. Like 
within a few seconds of becoming busy. I just discovered it is spitting 
out messages about "temperature way above maximum" (from therm_pm72.c).

	This one has the Panasonic cooling system. I have checked behind the 
cover and see no evidence of leaks.

	When put under load under the stock YDL kernel, the cpu fans will speed 
up for about 2 minutes. Then over the next minute or so they will slow 
down almost to idle. Thereafter a whirring sound can be heard every 15 
to 30 seconds lasting about 5 seconds. Which I am guessing is the pump? 
The exhaust air barely gets warm?

	Anyone have any ideas? Could the cooling system NOT be correctly 
thermally connected to the cpus?

kevin
