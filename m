To: "Q-ha Park" <qha@infoeq.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: using bdi2000 to debug ppcboot on mpc7455 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Sep 2003 14:52:33 +0900."
             <005e01c383f2$65430080$2a21a8c0@qha>
Date: Tue, 30 Sep 2003 23:35:24 +0200
Message-Id: <20030930213529.2F31BC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <005e01c383f2$65430080$2a21a8c0@qha> you wrote:
>
> Thanks a lot for your very informative reply; it helped me greatly and I
> can finally play with breakpoints. Although I failed to set the
> breakpoint at after_reloc but the point right before boart_init_r.

For debugging U-Boot / PPCBoot after relocation see
http://www.denx.de/twiki/bin/view/DULG/DebuggingUBoot#Section_9.1.2.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
