Return-Path: <Jogi95@web.de>
Received: from fmmailgate09.web.de (fmmailgate09.web.de [217.72.192.184])
	by ozlabs.org (Postfix) with ESMTP id B7423DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 17:16:32 +1000 (EST)
Date: Fri, 18 Jul 2008 09:16:28 +0200
Message-Id: <885675639@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: wsz_422@126.com
Subject: Re: hang on "booting the kernel ...."
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Perhaps you have the wrong entry in the kernel config at:

Platform options=AD>
     Initial kernel command string=AD>

It should be "(console=3DttyUL0 ............)".=20

Greez
Jogi

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Ihre Messenger, Communities und E-Mails jetzt in einem Programm!
WEB.DE MultiMessenger http://www.produkte.web.de/messenger/=3Fdid=3D3071
