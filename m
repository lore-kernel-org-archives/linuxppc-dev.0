Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: Assistance with using /dev/fb0 and No X windows
Date: Wed, 15 Jan 2003 12:53:09 +0100
Message-ID: <9367F79C9DBB8147AD58A96C933F008603BD87@men-exch.intra.men.de>
From: "Klaus Popp" <Klaus.Popp@men.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

You will find a framebuffer driver for the LynxEM chipset in the ELinOS distribution from SYSGO (www.elinos.com), name drivers/video/smiLynx.c

I was able to run text mode console, Qt/Embedded and X-Windows on top of this driver. However, this driver does not initialize videomode. It requires that the firmware has already setup the videomode correctly.

I have made an application note for this issue

http://www.men.de/download/default.asp?prod=21APPN003&lid=

Hope this helps

Mit freundlichen Grüssen / Best Regards

Klaus Popp, Head of Standard-Software Design
MEN Mikro Elektronik GmbH
Neuwieder Straße 7
90411 Nuremberg, Germany
Phone +49-911-99 33 5-61
Fax +49-911-99 33 5-99
E-Mail Klaus.Popp@men.de
www.men.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
