To: "challaharikumar" <challaharikumar@tataelxsi.co.in>
Cc: linuxppc-dev@lists.linuxppc.org, dan@embeddededge.com
Subject: Re: ADS8260 Hang 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Apr 2004 11:57:44 +0530."
             <001101c42832$ec117760$3401080a@telxsi.com>
Date: Thu, 22 Apr 2004 21:42:00 +0200
Message-Id: <20040422194205.4736EC109F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <001101c42832$ec117760$3401080a@telxsi.com> you wrote:
>
> I initially tried using Linux 2.4.1 kernel and it worked fine and the
> board was up.
> I upgraded to 2.4.17 and I found out that the system started hanging
> during boot up.

I guess you didn't read the FAQ; see
http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

I think you must unset the "clocks_in_mhz" environment variable.

> I tried tracking down where the hang could be and ended up at the RFI
> instruction where its waiting to complete the MMU initialization. The
> system executes SYNC instruction and then hangs. (arch/ppc/kernel/head.S)

I think you are hunting a ghost; and again you didn't read the FAQ; see
http://www.denx.de/twiki/bin/view/DULG/HowToSingleStepThroughRFIInstruction

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"When the only  tool  you  have  is  a  hammer,  you  tend  to  treat
everything as if it were a nail."                    - Abraham Maslow

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
