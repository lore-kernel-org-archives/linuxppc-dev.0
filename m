Return-Path: <thierry@sdl.hitachi.co.jp>
Received: from mailx.hitachi.co.jp (mailx.hitachi.co.jp [133.145.228.49])
	by ozlabs.org (Postfix) with ESMTP id 9D862DE232
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 17:30:20 +1100 (EST)
Received: from mlsv2.hitachi.co.jp (unknown [133.144.234.166])
	by mail4.hitachi.co.jp (Postfix) with ESMTP id CA3A133CC4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 15:23:26 +0900 (JST)
Received: from vshuts3.hitachi.co.jp (unverified) by MFILTER-S1.hitachi.co.jp
	(Content Technologies SMTPRS 4.3.17) with ESMTP id
	<T8d07b0a7cf0ac906aa980@MFILTER-S1.hitachi.co.jp> for
	<linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 15:23:26 +0900
Received: from hsdlgw92.sdl.hitachi.co.jp (unknown [133.144.7.20])
	by vshuts3.hitachi.co.jp (Symantec Mail Security) with ESMTP id
	89807774264
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 15:23:26 +0900 (JST)
Received: from sdl99w.sdl.hitachi.co.jp ([133.144.14.250])
	by vgate2.sdl.hitachi.co.jp (SAVSMTP 3.1.1.32) with SMTP id
	M2009031215232532218
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 15:23:25 +0900
Received: from [127.0.0.1]
	(IDENT:U2FsdGVkX18ofvtiVg77mbKGiu9mzkV8RkBwc741I8A@localhost.localdomain
	[127.0.0.1])
	by sdl99w.sdl.hitachi.co.jp (8.13.1/3.7W04031011) with ESMTP id
	n2C6NNGW026481
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 15:23:24 +0900
Message-ID: <49B8A9A1.4090908@sdl.hitachi.co.jp>
Date: Thu, 12 Mar 2009 15:20:17 +0900
From: FISCHER Thierry <thierry@sdl.hitachi.co.jp>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Linux boot problem, pc does not point to virtual memory
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
   
I am having some problem booting linux on Powerpc 405 (xilinx virtex4).

I have the following output on the terminal:
******************************************************
zImage starting: loaded at 0x00400000 (sp: 0x0070feb0)
Allocating 0x38a79c bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x0059ee42)...done 0x367f58 bytes
Attached initrd image at 0x0059f000-0x0070ef20
initrd head: 0x1f8b0808
 
Linux/PowerPC load: console=ttyUL0 root=/dev/ram
Finalizing device tree... flat tree at 0x71c300
*******************************************************
 
The strange thing is that when I check the value of pc register, it does 
not return values of the virtual memory but values like:
pc :0x0000ebd4
pc :0x00002148
pc :0x00002194
pc :0x00002150 ...
Instead of values like 0xcXXXXXXX
 
It looks like there is a problem with the MMU or something like that ?
I have seen similar problems on the xilinx forum but it did not helped 
me so much:
http://forums.xilinx.com/xlnx/board/message?board.id=ELINUX&message.id=595&query.id=371581#M595 

http://forums.xilinx.com/xlnx/board/message?board.id=EDK&message.id=6235&query.id=367949#M6235 

 
If anyone has experienced similar problem please let me know.
Any suggestion is welcomed.
 
Thanks,
