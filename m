Return-Path: <s.egbert@sbcglobal.net>
Received: from smtp104.sbc.mail.mud.yahoo.com (smtp104.sbc.mail.mud.yahoo.com
	[68.142.198.203]) by ozlabs.org (Postfix) with SMTP id DBAD6679F3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 17:06:18 +1100 (EST)
Message-ID: <43EADC0F.3040000@sbcglobal.net>
Date: Wed, 08 Feb 2006 22:07:11 -0800
From: "S. Egbert" <s.egbert@sbcglobal.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Getting started with Xilinx V4 PPC? (Jaap de Jong)
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

XIP in flash won't occur in ML403 reference design until you build a new
bit file with Xilinx side-by-side data fetch option enabled.
