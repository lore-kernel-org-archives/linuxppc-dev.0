Return-Path: <dok@directfb.org>
Received: from directfb.org (directfb.org [212.227.87.76])
	by ozlabs.org (Postfix) with SMTP id 3E7FDDDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 21:56:04 +1000 (EST)
Message-ID: <48AFF957.6060505@directfb.org>
Date: Sat, 23 Aug 2008 13:49:43 +0200
From: Denis Oliver Kropp <dok@directfb.org>
MIME-Version: 1.0
To: =?UTF-8?B?5YiY5bCP5Y+M?= <liuxs226@gmail.com>
Subject: Re: [directfb-dev] no output on screen
References: <e81b2fb40808222019hd8b7eb9va649b0771ed83f49@mail.gmail.com>
In-Reply-To: <e81b2fb40808222019hd8b7eb9va649b0771ed83f49@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: directfb-dev@directfb.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

刘小双 wrote:
> hi, all
> I am writing a gfxdriver for Fujitsu mb86296 video card under DirectFB. 
> When I run a example df_fire from DirectFB-examples-1.0.0.tar.gz, there 
> is  no output on the computer screen, it is black completely, and the 
> error result looks like this:
> 
> sh-3.00# ./df_fire
> 
>      =======================|  DirectFB 1.0.0  |=======================
>           (c) 2001-2007  The DirectFB Organization (directfb.org 
> <http://directfb.org>)
>           (c) 2000-2004  Convergence (integrated media) GmbH
>         ------------------------------------------------------------
> 
> (*) DirectFB/Core: Single Application Core. (2008-06-03 03:01) [ TRACE ]
> (*) Direct/Memcpy: Using ppcasm_memcpy()
> (*) Direct/Thread: Running 'VT Switcher' (CRITICAL, 502)...
> (*) Direct/Thread: Running 'PS/2 Input' (INPUT, 503)...
> (*) DirectFB/Input: IMPS/2 Mouse 1.0 (directfb.org <http://directfb.org>)
> (*) Direct/Thread: Running 'Keyboard Input' (INPUT, 504)...
> (*) DirectFB/Input: Keyboard 0.9 (directfb.org <http://directfb.org>)
> (*) DirectFB/Graphics: Fujitsu MB86296 0.5 (Atom Create)
> (!) [  493:    0.000] --> Caught signal 11 (at (nil), invalid address) <--
> (-) [  493: -STACK- ]
>   #0  0x0fecef48 in signal_handler () from 
> /mnt/gtkdfb/lib/libdirect-1.0.so.0
> [0xfec4000]
>   #1  0x0ffc5b40 in dfb_screens_initialize () from
> /mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]

The code you sent is looking fine. Please try a build with debug enabled (assertions).

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
