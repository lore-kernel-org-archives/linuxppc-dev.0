Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 56BF6DDE43
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 03:33:17 +1000 (EST)
Message-ID: <46B36753.2030309@ru.mvista.com>
Date: Fri, 03 Aug 2007 21:35:15 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 06/10] 40x decrementer fixes
References: <20070803160900.069522000@linux.vnet.ibm.com>	<20070803161710.931656000@linux.vnet.ibm.com>	<46B35C07.4090806@ru.mvista.com>	<46B3617B.10509@ru.mvista.com>	<20070803122512.26a24d99@weaponx.rchland.ibm.com>	<46B36651.8070209@ru.mvista.com>
	<20070803123043.76ff5233@weaponx.rchland.ibm.com>
In-Reply-To: <20070803123043.76ff5233@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:

>>>>>   Why bother doing this?! This will only warrant you imprecise decrementer 
>>>>>interrupts while it should be interrupting at the precise period currently (if 
>>>>>you load PIT once)...

>>>>   I.e. the error will only accumulate. NAK.

>>>What error exactly?  I'm not following you there.  If there really is
>>   I was assuming that the decrementer is in auto-reload mode.  Brain fade. :-<

> Heh, ok.  Glad I wasn't completely lost there :).

    Actually, the current set_dec() which you're fixing made me think so. :-)

> josh

WBR, Sergei
