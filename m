Return-Path: <enorm@126.com>
Message-ID: <004001c71a6b$e5c87150$8809a8c0@class>
From: "enorm" <enorm@126.com>
To: =?gb2312?B?s8LPow==?= <xchen@sunrisetelecom.com.cn>,
	<linuxppc-embedded@ozlabs.org>, <linuxppc-embedded-request@ozlabs.org>
References: <4578C0DC.0D5B9A.00597>
Subject: Re: When I use ichache_enable or dcache_enable in uboot,it crash
Date: Fri, 8 Dec 2006 09:55:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="gb2312"; reply-type=original
Cc: 'Elvis Ma' <npma@sunrisetelecom.com.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At the end of the "board_init_f()" function all data and code will be 
relocated to SDRAM. So, If you enable icache & dcache it will cause 
inconsistence between cache and Memory, so your program will crash




----- Original Message ----- 
From: "³ÂÏ£" <xchen@sunrisetelecom.com.cn>
To: "'enorm'" <enorm@126.com>; <linuxppc-embedded@ozlabs.org>; 
<linuxppc-embedded-request@ozlabs.org>
Cc: "'Elvis Ma'" <npma@sunrisetelecom.com.cn>
Sent: Friday, December 08, 2006 9:33 AM
Subject: Re: When I use ichache_enable or dcache_enable in uboot,it crash


Hi enorm

Thank you for your reply. In fact, the uboot has never disable
icache. The icache is enable at all times.And the code run in flash normally
when the icache is enable.  I have to add disable_icache() in the
board_init_f() so that the code can run in ram normally.  BTW, I just use
the function supported by uboot to enable icache&dcache, I'm sure the steps
of cache init have no problem. I just can't understand why the icache can
effect the code run in ram.

Thanks &Br,
Andy
