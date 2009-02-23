Return-Path: <sumedhtirodkar@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id AE613DDDA2
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 18:54:34 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2029439wfd.15
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 23:54:32 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 23 Feb 2009 13:24:32 +0530
Message-ID: <d2b9ccd90902222354o2e42db77h2f86fda45b5483b6@mail.gmail.com>
Subject: Problem with decrementer interrupt
From: sumedh tirodkar <sumedhtirodkar@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the handler for decrementer interrupt...there is a call to a C function...
Now if the call is removed...the decrementer interrupt works perfectly fine...
But if the C function is present, then the decrementer interrupt stops
coming after say 5-6 times...
Not able to find any reasoning for the same...
Has anyone come across this kind of problem?If yes, am i missing something?

Regards,
Sumedh
