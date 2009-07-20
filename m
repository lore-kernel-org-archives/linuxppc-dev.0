Return-Path: <hongwoo7@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by bilbo.ozlabs.org (Postfix) with ESMTP id EFEFCB70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 19:00:40 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id c5so565040rvf.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 02:00:39 -0700 (PDT)
Message-ID: <4A643219.3070004@gmail.com>
Date: Mon, 20 Jul 2009 18:00:09 +0900
From: HongWoo Lee <hongwoo7@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Simple question about powerpc kernel source. 
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I have something to ask for the ppc kernel source.

#define LOADADDR(rn,name)           \
    lis     rn,name##@highest;      \
    ori     rn,rn,name##@higher;    \
    rldicr  rn,rn,32,31;            \
    oris    rn,rn,name##@h;         \
    ori     rn,rn,name##@l

Is ## used for concatenation. I'm not sure because it is just meaningless.
If so what on earth is the result of concatenating ?

And is there a good reference to understand powerpc asm ?
I'm reading Power ISA, but I can't find @highest, @higher and ##.
It would be good to know the reference book.

Thanks in advance.


Regards,
HongWoo.
