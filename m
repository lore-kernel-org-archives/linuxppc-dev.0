Message-ID: <3F290464.7030902@imc-berlin.de>
Date: Thu, 31 Jul 2003 13:58:28 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: large file support?
References: <20030731113724.CB20BC602D@atlas.denx.de>
In-Reply-To: <20030731113724.CB20BC602D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> In message <3F28EFD6.3070803@imc-berlin.de> you wrote:
>
>>how could I find out if the kernel and the glibc I am using will
>>correctly supprot large files (>2GB)?
>
>
> 	char buf[4096];
> 	for (;;)
> 		write (fd, buf, sizeof(buf));
>

:o)

But what will happen if I (or my application) have no large file
support, i.e. is the failure deterministic? And will it be obvious?
Just by do "ls -l"????

:-)

Thanks anyway!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
