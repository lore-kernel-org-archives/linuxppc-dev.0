To: "LEROY Christophe" <christophe.leroy@c-s.fr>
Cc: liste ppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	TRINH-THAI Florent <florent.trinh-thai@c-s.fr>,
	POLI Herve <herve.poli@c-s.fr>,
	GUICHARD Michel <michel.guichard@c-s.fr>
Subject: Re: Can we use all SCCs with MPC860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 Dec 2002 10:34:39 +0100."
             <3DFD9E2F.CA7417EF@c-s.fr>
Date: Mon, 16 Dec 2002 10:51:36 +0100
Message-Id: <20021216095141.61DE5C6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Christophe,

in message <3DFD9E2F.CA7417EF@c-s.fr> you wrote:
>
> I have a board (home made) with a MPC862 running Montavista Linux 2.1
> (kernel 2.4.17).
> I'd like to use the four SCCs as serial ports, but it seems that only
> SCC2 and SCC3 can be configured as serial ports.

It's not difficult to extend the 8xx  UART  driver  to  support  both
SMC's  and  all  4 SCC's. This has been done before; see for examplee
the kernel source in our CVS server (module linux-2.4). This has been
tested and actually used (with hardware flowcontrol) on a  couple  of
boards.

> Does someone have any idea on how to configure SCC1 and SCC4 as serial
> ports also with that kernel ?

that kernel = MV Linux 2.1? Seems you should ask MV....


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Microsoft Compatibility:
     your old Windows 3.11 application crash exactly as the new ones.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
