Message-ID: <64AFC0D37B2ED411BAB300508B6D90A019AA54@AVALANCHE>
From: Dan Winkler <dwinkler@virtual-ink.com>
To: "'clark@esteem.com'" <clark@esteem.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: SPI driver?
Date: Wed, 8 Nov 2000 16:18:31 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a working SPI and I2C driver with and without the microcode patch
(I'm currently using it in slave mode but it can be easily modified to work
in master mode).  I'll e-mail  them after I clean them up a bit.

-Dan Winkler

-----Original Message-----
From: clark@esteem.com [mailto:clark@esteem.com]
Sent: Wednesday, November 08, 2000 1:13 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: SPI driver?



	Hello,

	I was wondering if anbody has a working SPI driver yet. I noticed
one that
wasn't working yet was included in HHL 1.2 . Has anyone made any progress
on it since then? I also noticed it relied on CPM_IIC micro code patch
,  does it have any known side effects?

Many thanks in advanced

	Conn Clark
*****************************************************************
   If you live at home long enough, your parrents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

Stock Ticker Symbol				ELST

"clark@esteem.com" Copyright 2000 all rights reserved. May not be sold or
used for advertisements.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
