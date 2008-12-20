Return-Path: <sumedhtirodkar@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by ozlabs.org (Postfix) with ESMTP id 49AB7DDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Dec 2008 03:07:14 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so763745fke.9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Dec 2008 08:07:04 -0800 (PST)
Message-ID: <d2b9ccd90812200807k59ae3b30j832ad752f297d350@mail.gmail.com>
Date: Sat, 20 Dec 2008 21:37:04 +0530
From: "sumedh tirodkar" <sumedhtirodkar@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: yaboot: text mode or graphics mode?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does anyone knw what happens when we boot into yaboot,whether we are
in text mode or graphics mode? If text mode then wat is the address of
the screen? I need it to print some debug info..bt i either dnt seem
to get the buffer address correct or i m not in text mode as yaboot
has already switched to some other mode...

Regards,
Sumedh
