Return-Path: <rth7680@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdz62042FzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 06:12:26 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id l39so7080548qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 13:12:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
Subject: Re: [PATCH] tty: add TIOCGPTPEER ioctl
To: Aleksa Sarai <asarai@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>
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
 <a0671efc-4c4e-bbdc-c9d8-a7bdc22b872a@suse.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4e16e83b-8fb7-c9b6-2f06-ee48499a67db@twiddle.net>
Date: Thu, 1 Jun 2017 13:12:15 -0700
MIME-Version: 1.0
In-Reply-To: <a0671efc-4c4e-bbdc-c9d8-a7bdc22b872a@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2017 01:00 PM, Aleksa Sarai wrote:
>>> --- a/arch/alpha/include/uapi/asm/ioctls.h
>>> +++ b/arch/alpha/include/uapi/asm/ioctls.h
>>> @@ -94,6 +94,7 @@
>>>   #define TIOCSRS485     _IOWR('T', 0x2F, struct serial_rs485)
>>>   #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
>>> pty-mux device) */
>>>   #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
>>> +#define TIOCGPTPEER    _IOR('T', 0x41, int) /* Safely open the slave */
>>
>> Shouldn't the list of definitions be kept sorted, by hex number?
>> (everywhere)
> 
> Probably. The reason I put it here is because it logically is very similar to 
> TIOCGPTN and TIOSPTLCK, but I can move it if the hex order is more important 
> for maintainence.
> 

Yes please.


r~
