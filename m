Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 017DC67A6B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 00:46:44 +1100 (EST)
Message-ID: <4227153C.3030201@gmx.net>
Date: Thu, 03 Mar 2005 14:46:36 +0100
From: evilninja <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <20050303124435.GA24233@Redstar.dorchain.net>
In-Reply-To: <20050303124435.GA24233@Redstar.dorchain.net>
Content-Type: text/plain; charset=UTF-8
Subject: Re: GCC4 fun.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joerg Dorchain wrote:
> Hi list,
> 
> I just booted a self-compiled 2.6.11 on my iBook G4.
> 
> The dmesg shows a hickup, where I am wondering what's the cause.
> 
> Total memory = 768MB; using 2048kB for hash table (at c0400000)
> Linux version 2.6.11 (root@whisker) (gcc version 3.3.5 (Debian 1:3.3.5-8))
- ---------------------------------------------------^

what does this have to do with your subject? ("GCC4 fun.")

> scheduling while atomic: swapper/0x00000002/0
> Call trace:
>  [c0007620] dump_stack+0x18/0x28
>  [c01de704] schedule+0x678/0x67c
>  [c0004500] syscall_exit_work+0x108/0x10c
>  [c02a97b4] proc_root_init+0x168/0x174
>  [ff847288] 0xff847288
>  [c02945e8] start_kernel+0x144/0x170
>  [00003a30] 0x3a30

did you try the various -rc kernels before 2.6.11? did it happen with
these too?

i don't know why you're getting this error, but seeing "swapper" to be
involved here: can you compile with CONFIG_SWAP=n and boot this one?

Christian.
- --
BOFH excuse #440:

Cache miss - please take better aim next time
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCJxU8C/PVm5+NVoYRAkYTAKCqSqJyhy2yGYPEG6ZQWs3oaqI7KQCfeGCW
rfBeUbJ5EhS4Fx0L5kvh4a8=
=vIIE
-----END PGP SIGNATURE-----
