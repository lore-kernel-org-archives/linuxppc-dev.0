To: Marc Leeman <marc.leeman@barco.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc-82xx_objcopy hangs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 13 May 2004 13:07:25 +0200."
             <20040513110725.GU4043@smtp.barco.com>
Date: Thu, 13 May 2004 18:16:33 +0200
Message-Id: <20040513161638.C3444C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040513110725.GU4043@smtp.barco.com> you wrote:
>
> 2. when compiling the ppcboot-2.0.0-custom sources (with support for our
> system), the compilation succeeds, but
> ppc_82xx-objcopy --gap-fill=0xff -O srec ppcboot ppcboot.srec
> gets stuck.
>
> Idem for a system where I only brought in a couple of changes from the
> old sources. Any ideas as to what code might cause this problem?

Seems you version of objcopy is broken. Try using the native objcopy,
or the cross objcopy from the ELDK.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Tell the truth and run."                          - Yugoslav proverb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
