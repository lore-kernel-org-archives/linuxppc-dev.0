To: Mike Hill <mhill@bustech.com>
Subject: Re: Kernel panic: No init found.
Message-ID: <976723256.3a379d38783d0@mail.serialsystem.com.sg>
Date: Thu, 14 Dec 2000 00:00:56 +0800 (SGT)
From: Jari Nguyen Trung Thanh <jari.nguyen@serialsystem.com.sg>
Cc: Nils Hagge <Nils.Hagge@stud.uni-hannover.de>,
        linuxppc-embedded@lists.linuxppc.org
References: <006c01c0650f$73b65d60$1e894b82@pc30> <004801c0651d$3a7d96e0$e3e8b2c6@hawk>
In-Reply-To: <004801c0651d$3a7d96e0$e3e8b2c6@hawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mike Hill and Nils Hagge,

Quoting Mike Hill <mhill@bustech.com>:

>
> I believe I have seen the same problem.  As I recall, we first started
> seeing this problem when we removed a symlink (/opt/hardhat/devkit to /)
> that was included in the MontaVista target directory.  We were told that
> we
> had it add it back because some of the MontaVista libraries were built
> incorrectly.

Oh, I forgot it, it happened to me in the past, too.
However, this just supports for building another application which can use the
library in the root/lib directory, when it run in the embedded systems...

 You may want to check to see if you have that symlink in
> your
> target directory.
>
Hope this help,
Jari

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
