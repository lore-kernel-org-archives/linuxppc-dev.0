Return-Path: <arunkat@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id 8110367BC8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 04:16:57 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so192641wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 09:16:56 -0800 (PST)
Message-ID: <edd12c050611160916y1581e270l5ddd8016a0720eca@mail.gmail.com>
Date: Thu, 16 Nov 2006 22:46:53 +0530
From: "Arun Kumar" <arunkat@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: unhadled reloc 18
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_18554_16349497.1163697413482"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_18554_16349497.1163697413482
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,
I am using k2.4.2 with cross compiler for PowerPC 8245 platform .
When I try to do an insmod of my driver it complains

unhandled reloc 18
insmod: Unhandled relocation of type 18 .......

for all the symbols in the driver .

I am compiling my driver as a module using -fPIC and then doing ld -r
mydriver -o mydrivernew `gcc -print-libgcc-file-name`

When I do an insmod mydrivernew it gives these relocation errors .

The reason why i using ld is that my code uses 64 bit division on 32 biut
platform so when i try to do insmod mydriver
it says undefined symbol __udivdi3

I am able to locate this symbol in libgcc and hence I am trying to include
it with my driver mydriver since I am not able to compile my kernel with gcc
as this library symbol __udivdi3 is not exported in my kernel image when
linked with libgcc with vmlinux .

Please suggest me how to get rid of these relocation warnings ???

Thanks
Arun

------=_Part_18554_16349497.1163697413482
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,<br>I am using k2.4.2 with cross compiler for PowerPC 8245 platform .<br>When I try to do an insmod of my driver it complains <br><br>unhandled reloc 18<br>insmod: Unhandled relocation of type 18 .......<br><br>for all the symbols in the driver .
<br><br>I am compiling my driver as a module using -fPIC and then doing ld -r mydriver -o mydrivernew `gcc -print-libgcc-file-name`<br><br>When I do an insmod mydrivernew it gives these relocation errors .<br><br>The reason why i using ld is that my code uses 64 bit division on 32 biut platform so when i try to do insmod mydriver
<br>it says undefined symbol __udivdi3 <br><br>I am able to locate this symbol in libgcc and hence I am trying to include it with my driver mydriver since I am not able to compile my kernel with gcc as this library symbol __udivdi3 is not exported in my kernel image when linked with libgcc with vmlinux .
<br><br>Please suggest me how to get rid of these relocation warnings ???<br><br>Thanks<br>Arun<br><br><br clear="all"><br>

------=_Part_18554_16349497.1163697413482--
