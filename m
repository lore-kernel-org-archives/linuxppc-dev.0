Message-ID: <3C8FD16D.2060003@embeddededge.com>
Date: Wed, 13 Mar 2002 17:23:41 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Leiying Du <ldu@solectek.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Debug kernel ELF using SDS single-step debugger
References: <005701c1cad8$d397eb60$6649a8c0@LEIYINGDU>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Leiying Du wrote:

> When I run the kernel ELF, I always get this error message "Couldn't find
> 4096 bytes at 4096 alignment".

Well, you can't run the kernel ELF image (vmlinux) directly.  This error
is because you are not telling the kernel information it needs to know
from start up parameters.  These are provided by some form of bootloader.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
