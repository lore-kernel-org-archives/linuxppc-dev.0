Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <boot-6-11.miltonm@bga.com>
References: <boot-6-11.miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <45AA4DEF-F8CC-4360-85D6-E22FED87059F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/15] bootwrapper: allow vmlinuz to be an external payload
Date: Wed, 11 Jul 2007 01:11:15 +0200
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Allow the boot wrapper to obtain the vmlinux elf from an external
> platform supplied location instead of embedding it at link time.
>
> When used with the cpio library, the kernel can be stored as a file
> an file in the initramfs, allowing the same (compressed) copy of
> the vmlinux elf to be used for both the kernel to execute and any
> user space tools such as kexec (for reboot), crash dump, or oprofile.

Awesome!


Segher
