To: "Thamarai Selvan" <Thamarai.Selvan@lntinfotech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting emlinux on customized MPC860 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 Jan 2004 15:02:19 +0530."
             <OFC1528F5C.1343245D-ON65256E1A.0034551B@lntinfotech.com>
Date: Tue, 13 Jan 2004 18:53:18 +0100
Message-Id: <20040113175323.32FCBC10AF@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OFC1528F5C.1343245D-ON65256E1A.0034551B@lntinfotech.com> you wrote:
>
> I would like u all to help me out with porting issue currently iam having.
> The customised MPC860 board [target], we have  doesnt have any bootloader
> or code in its ROM
> If i need to port emlinux from my host what related steps i should take
> from the view of target.

Step 1: get access to a BDI2000
Step 2: port / adapt U-Boot to your board
Step 3: port / adapt Linux to your board (large parts just copy & paste
        from the U-Boot drivers).

> if anyone could direct me on to the documents available on emlinux and

http://www.denx.de/twiki/bin/view/PPCEmbedded/Introduction ?
http://www.denx.de/twiki/bin/view/DULG/Manual ?

> This is my first venture towards Linux/emlinux.

Hope this helps.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are three principal ways to lose money: wine, women, and engi-
neers. While the first two are more pleasant, the third is by far the
more certain."                           - Baron Rothschild, ca. 1800

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
