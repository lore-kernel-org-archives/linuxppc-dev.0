Return-Path: <lonsn@163.com>
Received: from 163.com (m12-15.163.com [220.181.12.15])
	by ozlabs.org (Postfix) with SMTP id EBA18679EF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 15:57:58 +1100 (EST)
Date: Thu, 16 Feb 2006 12:45:15 +0800
From: "=?utf-8?B?5buW6I2j55Sf?=" <lonsn@163.com>
To: "=?utf-8?B?RXVnZW5lIFN1cm92ZWdpbg==?=" <ebs@ebshome.net>
Subject: =?utf-8?B?UmU6IFJlOiBHaWdhYml0IGV0aGVybmV0IHN1cHBvcnQgb2YgcHBjNDQwZ3ggaW4gMi42IGFuZCAyLjQ=?=
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Message-Id: <43F4065B.02743C.08305>
Cc: =?utf-8?B?bGludXhwcGMtZW1iZWRkZWQ=?= <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Eugene:

Does the TCP/IP Acceleration Hardware of 440GX have been supported in official 2.6 kernel?
How about the CPU utilization when you get 900+Mb/s? Since we want to do something such as simple datas codec at the same time.

Regards,

Lonsn
 
>
>On Wed, Feb 15, 2006 at 02:08:52PM +0800, ????????? wrote:
>> We want to get a data rate of 600Mbits/s over gigabit ethernet of ppc440gx.
>> How about the status of support to ppc440gx GigE in Linux kernel?
>> Which kernel version should we select? 2.6 or 2.4?
>
>GigE support for 440GX is in official 2.6. Patch for 2.4 is available 
>at http://kernel.ebshome.net. If you don't feel comfortable dealing 
>with kernel patches, I'd recommend 2.6
>
>Effective Ethernet throughput highly depends on packet size. For some 
>small packet sizes 600Mb/s is theoretically impossible over GigE.
>
>I achieved 900+ Mb/s TCP throughput with my driver (packets around 4K 
>long) and using sendfile(2) based test application.
>
>-- 
>Eugene
>
>
