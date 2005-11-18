Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BA85868775
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 01:09:06 +1100 (EST)
Message-ID: <437DE07E.6080005@ru.mvista.com>
Date: Fri, 18 Nov 2005 17:09:02 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
In-Reply-To: <20051117135810.GB9753@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo,
Thanks for review, will fix.

Guess the proper place for setbits/clrbits should be asm-ppc/io.h?


-- 
Sincerely,
Vitaly
