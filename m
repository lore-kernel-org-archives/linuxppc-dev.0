Return-Path: <evilninja@gmx.net>
Message-ID: <41CAC150.5040903@gmx.net>
Date: Thu, 23 Dec 2004 14:00:00 +0100
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: 2.6-BK compile errors 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi,

compiling latest 2.6-BK kernel every day with a crosscompile toolchain, 
there are errors for the ppc32 (PReP) here since yesterday.
details here:

http://nerdbynature.de/bits/sheep/latest-kernel/errors-2.6-ppc-BK.log
http://nerdbynature.de/bits/sheep/latest-kernel/warnings-2.6-ppc-BK.log
http://nerdbynature.de/bits/sheep/latest-kernel/make-2.6-ppc-BK.log
http://nerdbynature.de/bits/sheep/latest-kernel/config-ppc-2.6.10-rc3

this was made with:

powerpc-604-linux-gnu-gcc 3.4.2

GNU ld version 2.15
   Supported emulations:
    elf32ppclinux
    elf32ppc
    elf32ppcsim

tell me, if more details are needed.

thanks,
Christian.
