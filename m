Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15713.mail.cnb.yahoo.com (web15713.mail.cnb.yahoo.com
	[202.165.103.224]) by ozlabs.org (Postfix) with SMTP id 037DCDDE00
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 17:57:38 +1100 (EST)
Date: Wed, 28 Feb 2007 14:50:57 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
Subject: Re: Memory unstable problem
To: enorm <enorm@126.com>
In-Reply-To: <002b01c758b1$76b61a90$7809a8c0@lastone>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Message-ID: <212325.29587.qm@web15713.mail.cnb.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

enorm <enorm@126.com> wrote:
> Our board uses DDR2 667 MHz( the evm board can
> support so), when its data rate is 320 or 400
> MHz it's stable, when data rate reaches 533 or
> 667 MHz it became unstable. What may cause it?
> Your answers are great appreciated.

It is really a DDR2 setup issue. Pls try to
adjust the timing parameter in your boot code.

Questions could be better to sent to boot code
list RATHER THAN OS list.

Best regards,

Sam


		
___________________________________________________________ 
—≈ª¢√‚∑—” œ‰-3.5G»›¡ø£¨20M∏Ωº˛ 
http://cn.mail.yahoo.com/
