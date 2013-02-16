Return-Path: <phileas-fogg@mail.ru>
Received: from fallback1.mail.ru (fallback1.mail.ru [94.100.176.18])
 by ozlabs.org (Postfix) with ESMTP id 1D9DF2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 20:53:42 +1100 (EST)
Received: from smtp30.i.mail.ru (smtp30.i.mail.ru [94.100.177.90])
 by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id 920891077108
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 13:53:39 +0400 (MSK)
Message-ID: <511F652F.4090508@mail.ru>
Date: Sat, 16 Feb 2013 11:53:35 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Phileas Fogg <phileas-fogg@mail.ru>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru>
In-Reply-To: <1360365046.495584377@f356.mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I was able to capture the debug output from the purgatory code and it's very odd.

This the SHA256 digest calculated by kexec-tools:

root@ps3-linux:~# kexec -l loader.ps3
Warning: append= option is not passed. Using the first kernel root partition
Modified cmdline:
Unable to find /proc/device-tree//chosen/linux,stdout-path, printing from 
purgatory is diabled
segment[0].mem:0x131d000 memsz:262144
segment[1].mem:0x135d000 memsz:36864
segment[2].mem:0x7fff000 memsz:4096
sha256_digest: 77 d5 30 a7 67 5f 67 93 f1 e0 ce 84 bd 4e 1b ec 3c 4a 9e 86 5c a1 
33 87 9e b1 5f c8 91 ce e8 61


And this is the debug output i'm always getting from the purgatory code:

I'm in purgatory
sha256 digests do not match :(
        digest: fd 4f df a8 af 5b e1 6b bc 51 5d b8 ab be 75 fb 76 fd 64 64 26 
3e a8 9f 46 ec 91 de 05 4e 72 78
sha256_digest: 00 39 e3 b2 45 0d 20 68 74 c2 4e ee e4 4a cf ec c3 78 4f 1c 65 ff 
a8 76 73 68 5d 01 70 0b b6 50

regards
