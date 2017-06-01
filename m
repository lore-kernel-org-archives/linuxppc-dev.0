Return-Path: <asarai@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdyrJ2VXKzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 06:00:31 +1000 (AEST)
Subject: Re: [PATCH] tty: add TIOCGPTPEER ioctl
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Valentin Rothberg <vrothberg@suse.com>
References: <20170601173803.8698-1-asarai@suse.de>
 <CAMuHMdXkaWg70OidDi0_xALbzwZ+o0eEVEzT5U_6HdewBs4WwA@mail.gmail.com>
From: Aleksa Sarai <asarai@suse.de>
Message-ID: <a0671efc-4c4e-bbdc-c9d8-a7bdc22b872a@suse.de>
Date: Fri, 2 Jun 2017 06:00:17 +1000
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXkaWg70OidDi0_xALbzwZ+o0eEVEzT5U_6HdewBs4WwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> --- a/arch/alpha/include/uapi/asm/ioctls.h
>> +++ b/arch/alpha/include/uapi/asm/ioctls.h
>> @@ -94,6 +94,7 @@
>>   #define TIOCSRS485     _IOWR('T', 0x2F, struct serial_rs485)
>>   #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
>>   #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
>> +#define TIOCGPTPEER    _IOR('T', 0x41, int) /* Safely open the slave */
> 
> Shouldn't the list of definitions be kept sorted, by hex number?
> (everywhere)

Probably. The reason I put it here is because it logically is very 
similar to TIOCGPTN and TIOSPTLCK, but I can move it if the hex order is 
more important for maintainence.

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
