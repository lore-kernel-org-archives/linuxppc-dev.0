Return-Path: <deboralh@fel.com.cn>
Date: Wed, 14 Dec 2005 09:39:32 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "HappyPhot" <happyphot@gmail.com>
Message-Id: <200512140929125.SM00772@RavProxy>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: how to define BASE_BAUD
Reply-To: deboralh@fel.com.cn
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, HappyPhot

In message <2005-12-14 01:19:49 happyphot@gmail.com> you wrote:

>   Can anybody tell me how to define the "BASE_BAUD" value
>for the "struct serial_state rs_table[]" ?
>  It seems has different value for each platform !!

yes, this is different for each platform.
see your crystal used by UART.

　　　　　　　　Debora Liu
　　　　　　　　deboralh@fel.com.cn
　　　　　　　　　　2005-12-14
