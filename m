Return-Path: <wd@denx.de>
To: =?iso-8859-1?Q?J=F6rg_Huwig?= <jhuwig@intec-isdn.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Nov 2004 16:24:54 +0100."
	<04113016200014900@intec-isdn.de>
Date: Tue, 30 Nov 2004 17:24:51 +0100
Sender: wd@denx.de
Message-Id: <20041130162456.5D24AC1430@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: USB driver for ISP1362 very slow 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

in message <04113016200014900@intec-isdn.de> you wrote:
> 
> I'm using an ISP1362 as an USB host controller connected to a MPC880 running
> under Linux 2.4.25.
> The Driver seems to work fine as I can mount an USB memory stick. 
> But the performance is very bad. To copy a 1MByte big file from the USB
> memory stick to the RAM disk takes about 3 minutes. 

Are there any error messages in the log files? Did  you  try  another
USB memory stick, especially any USB 2.0 stick?

> Does anyone has experience with the ISP1362 driver in Kernel 2.4.25??

Sure. We implemented it and tested it with mass storage devices,  USB
modems, network adapters and in combination with RNDIS on Windoze.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"I find this a nice feature but it is not according to  the  documen-
tation. Or is it a BUG?"   "Let's call it an accidental feature. :-)"
                       - Larry Wall in <6909@jpl-devvax.JPL.NASA.GOV>
