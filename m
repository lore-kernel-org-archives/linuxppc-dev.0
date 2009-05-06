Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 6E9D7DDFDF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:34:19 +1000 (EST)
To: "Shubhada Pugaonkar" <shubhada@chelsio.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Unable to boot 2.6.29 (and tot kernel) with 256k page size on
	katmai.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <8A71B368A89016469F72CD08050AD33402D575FA@maui.asicdesigners.com>
References: <8A71B368A89016469F72CD08050AD33402D575FA@maui.asicdesigners.com>
Date: Thu, 07 May 2009 00:34:15 +0200
Message-Id: <20090506223415.C42F983420E8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Shubhada,

In message <8A71B368A89016469F72CD08050AD33402D575FA@maui.asicdesigners.com> you wrote:
> 
> I am unable to boot the 2.6.29-rc8 denx kernel (and 2.6.30-rc4 tot
> kernel) when I enable the 256k page size. My config file is attached.
> The *same* config works fine with 64k page size. I have 2GB memory on
> this board. 

Which root file system are you using?

> ## Booting image at 01000000 ...
>    Image Name:   Linux-2.6.29-rc8-01447-g3bf8ce5-
>    Created:      2009-05-05   0:31:36 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    2138773 Bytes =  2 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using the fdt at 0x4000000
>    Loading Device Tree to 007fb000, end 007fefff ... OK

Is this all you get? Nothing else?


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Nobody will ever need more than 640k RAM!"       -- Bill Gates, 1981
"Windows 95 needs at least 8 MB RAM."             -- Bill Gates, 1996
"Nobody will ever need Windows 95."             -- logical conclusion
