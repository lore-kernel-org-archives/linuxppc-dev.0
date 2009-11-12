Return-Path: <jblack547@gmail.com>
MIME-Version: 1.0
Date: Thu, 12 Nov 2009 16:08:07 -0700
Message-ID: <b77025b40911121508l350e629bt7adaa9da936788d5@mail.gmail.com>
Subject: kexec for powerpc
From: James Black <jblack547@gmail.com>
To: Linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Are there efforts in this area or is it already working for powerpc? I
cross compiled kexec and tried it on an old kernel with kexec support
compiled in.

/var # ./kexec -t elf -l zImage.elf
get_memory_ranges(): Unsupported platform
Could not get memory layout

Any comments?

-- 
Jim Black
