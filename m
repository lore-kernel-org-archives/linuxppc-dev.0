Return-Path: <jhuwig@intec-isdn.de>
From: =?iso-8859-1?Q?J=F6rg_Huwig?= <jhuwig@intec-isdn.de>
To: <Linuxppc-embedded@ozlabs.org>
Date: Tue, 30 Nov 2004 16:24:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-Id: <04113016200014900@intec-isdn.de>
Subject: USB driver for ISP1362 very slow
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm using an ISP1362 as an USB host controller connected to a MPC880 running
under Linux 2.4.25.
The Driver seems to work fine as I can mount an USB memory stick. 
But the performance is very bad. To copy a 1MByte big file from the USB
memory stick to the RAM disk takes about 3 minutes. 

Does anyone has experience with the ISP1362 driver in Kernel 2.4.25??


Regards

Joerg Huwig
