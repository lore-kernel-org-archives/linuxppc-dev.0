To: "Marco Schramel" <marco.schramel@go.bartec.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC Boot for MPC8270 and MPC866 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 04 Aug 2003 13:43:30 +0200."
             <MFEGIPJEFHIKHGDLDACIGEOFCAAA.marco.schramel@go.bartec.de>
Date: Mon, 04 Aug 2003 17:15:34 +0200
Message-Id: <20030804151539.BEF77C602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Marco,

in message <MFEGIPJEFHIKHGDLDACIGEOFCAAA.marco.schramel@go.bartec.de> you wrote:
>
> are there is a PPC BOOT supporting the new 8270 USB Host feature ? (UBOOT
> 0.4.0 ?? )

You are off topic here. Please post U-Boot related questions  to  the
U-Boot-users mailing list.

So far there is no 8270 USB support.

> Is the new 866 still supported ?

Why should anybody remove the support for a pretty recent CPU?

> Is it difficult to implement new routines for some asics or is it better do
> wirte some device driver for it ?

Did you have a look at the existing code? There is  a  lot  of  stuff
ready available, including support for Xilinx and Altera FPGAs.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Anyone who doesn't believe in miracles is not a realist.
                                                   - David Ben Gurion

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
