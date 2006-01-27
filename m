Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id D025468A8F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jan 2006 19:49:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: mpc82xx USB host driver
Date: Fri, 27 Jan 2006 09:22:32 +0100
Message-ID: <47F3F98010FF784EBEE6526EAAB078D1C05FC4@tq-mailsrv.tq-net.de>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Dubb, Benjamin" <Benjamin.Dubb@ipc.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ben,

linuxppc-embedded-bounces@ozlabs.org wrote on Thursday, January 26,
2006 6:55 PM:=20
> I'm unable to find a 2.4 usb host driver for the pq3/pq2. Can someone
> post a patch here or point me to it, please.=20
> Thanks,

The cpm2usb project might be what you are looking for:
http://cpm2usb.sourceforge.net

But I'm not sure if the driver runs on Linux 2.4, though.

Regards,
Martin
