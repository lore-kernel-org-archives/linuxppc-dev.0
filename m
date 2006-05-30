Return-Path: <adgospod@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id 0527C67B34
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 07:22:29 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 69so131612wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 14:22:28 -0700 (PDT)
Message-ID: <bdfc5d6e0605301415x6928563cub526c1497deed337@mail.gmail.com>
Date: Tue, 30 May 2006 17:15:44 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
Subject: Re: execve of /sbin/init fails
In-Reply-To: <EDF27F298D4B03498AE0C249A941DFF803D6DE@de01exm68.ds.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <EDF27F298D4B03498AE0C249A941DFF803D6DE@de01exm68.ds.mot.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You could also try compiling init statically.  I've had success with
that in the past until I figured out what the actual problem was.


On 5/30/06, Anantharaman Chetan-W16155
<Chetan.S.Anantharaman@motorola.com> wrote:
>
>
>
>
> Hi,
>
> I am trying to bring up a custom board with a PPC405 processor running Linux
> 2.4.20 (MontaVista Release) and am having problems with the call to
> execve("/sbin/init", argv_init, envp_init) not returning in the file main.c.
> The processor just hangs and there is no output on the terminal. I have
> tried to see if I can run "bin/sh" and even this execve call does not
> return. Some things about the board are, the networking option has been
> disabled in the Linux .config file. I am running U-Boot 1.1.1 as the
> bootloader and am downloading the uImage (compressed kernel) and the
> initrd.boot (filesystem) into RAM and accessing the filesystem in RAM.
>
>
>
> Any help as to what could be causing this to happen or how to debug this
> issue would be appreciated. Also, I've tried to capture the return value of
> the execve call but since the call does not return, this has not helped any.
>
>
>
> Thanks,
>
> Chetan Anantharaman
>
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
