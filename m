Return-Path: <DavidHo@nanometrics.ca>
Received: from mail.nanometrics.ca (mail.nanometrics.ca [206.191.47.130])
	by ozlabs.org (Postfix) with SMTP id AA7DB67A74
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 04:01:51 +1100 (EST)
To: Wolfgang Denk <wd@denx.de>
Message-ID: <OFAA7E66FB.78AF3A29-ON85256F9B.005B85BD-85256F9B.005C32E2@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Tue, 1 Feb 2005 11:47:02 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Testing ISP1362 USB network device driver.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

I'm testing the device side of the ISP1362 using your USB network driver.
I can get a PC to enumerate with the 1362 but then I don't have a windows
driver to route IP traffic to it.  I'm just curious how you test the
driver?  Do you have a Linux host side driver to communicate with the 1362
as a USB NIC device?

Thanks,
David H.
