Return-Path: <wizarddewhite@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CEC5EB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 17:25:29 +1000 (EST)
Received: by wwj40 with SMTP id 40so4134363wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Aug 2011 00:25:24 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 1 Aug 2011 15:25:24 +0800
Message-ID: <CAOkaeL+Tjax1q2k8wYKAjVU2mTfD4JTQoxumBdeGV5Z_8Nmzww@mail.gmail.com>
Subject: For Power Arch, the Exception Vector always locate at 0x0100-0x0FFF
	physical address?
From: Wizard <wizarddewhite@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

I am not sure whether this is the right place for this question.

>From the PEM, it says the physical area is reserved for the exception
vector, this is always true?
And how many vectors could it hold?

-- 
Wizard
