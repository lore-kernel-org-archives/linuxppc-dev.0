Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id F1363DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Mar 2008 13:02:23 +1100 (EST)
Message-ID: <405458842.27358@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: "Grant Likely" <grant.likely@secretlab.ca>
Date: Fri, 14 Mar 2008 09:40:42 +0800
Subject: Re: [U-Boot-Users] Hi, friends,
	the question about the u-boot and device tree?
Content-Type: text/plain
Cc: u-boot-users@lists.sourceforge.net, support.asia@freescale.com,
	linuxppc-embedded@ozlabs.org
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,friends,

I¡¡made follow define on my MPC8360EMDS.h file. Is it enough? The uboot still did
not fill the zero frequency on dtb. I think the ft_cpu_setup and ft_board_setup
function have been run.


/* pass open firmware flat tree */
#define CONFIG_OF_FLAT_TREE	         1
#define CONFIG_OF_BOARD_SETUP	1
/* maximum size of the flat tree (8K) */
#define OF_FLAT_TREE_MAX_SIZE	8192


>From: "Grant Likely" <grant.likely@secretlab.ca>
>Reply-To: 
>To: "¹ù¾¢" <guojin02@tsinghua.org.cn>
>Subject: Re: [U-Boot-Users] Hi, friends, the question about the u-boot and device
tree?
>Date:Thu, 13 Mar 2008 13:21:35 -0600
>
>On Thu, Mar 13, 2008 at 9:31 AM, ¹ù¾¢ <guojin02@tsinghua.org.cn> wrote:
>> Hi,friends,
>>
>>  I make all the frequency(timebase-frequency;bus-frequency;clock-frequency)
value
>>  on device tree file equal to zero, I think those frequency will filled by
u-boot
>>  during bootm, but in fact, the u-boot did not fill any frequency. after
bootm,
>>  crashed. Why?
>>
>>  Why so many document point out that the zero value will be filled by u-boot?
>
>In most cases it will assuming that your u-boot board port is
>configured to fill in those values.  You need to make sure that the
>ft_board_setup function is getting called by bootm and that it fills
>in those properties.
>
>g.
>
>-- 
>Grant Likely, B.Sc., P.Eng.
>Secret Lab Technologies Ltd.
> 
