Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15810.mail.cnb.yahoo.com (web15810.mail.cnb.yahoo.com
	[202.165.102.90]) by ozlabs.org (Postfix) with SMTP id 9591367E69
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 23:38:38 +1000 (EST)
Message-ID: <20050802133835.30133.qmail@web15810.mail.cnb.yahoo.com>
Date: Tue, 2 Aug 2005 21:38:34 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Carl Ljungmark <carl.ljungmark@sysgo.com>
In-Reply-To: <op.suvg7mug0c7u6q@clj.sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re : MPC8245+2.6.12=oops
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Carl Ljungmark <carl.ljungmark@sysgo.com> wrote:
> Trying to boot linux 2.6.12 on an MPC8245 board from
> MEN (a12) with MenMon  
> firmware. Nothing is printed to the console (ttyS0),
> but the __log_buf contains this:
> 
> <4>entering platform_init.

Seems sth wrong on target init configuration. Pls 
check some values like MPC10X_MAPB_EUMB_BASE or 
UART related stuff like SERIAL_PORT_DFNS. Well, I 
just have the successful experience on a MPC8241 
target based on SANDPOINT board with 2.6.12-rc2 and 
2.6.13-rc3. 

In addition, enable early console is also a help to
debug.

Best regards,

Sam

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
