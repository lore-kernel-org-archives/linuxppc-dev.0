Return-Path: <j.glisse@free.fr>
Received: from postfix2-c.free.fr (postfix2-c.free.fr [213.228.0.80])
	by ozlabs.org (Postfix) with ESMTP id B2ED12BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Dec 2004 08:56:36 +1100 (EST)
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by postfix2-c.free.fr (Postfix) with ESMTP id E26859ACC3A
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Dec 2004 22:20:31 +0100 (CET)
Message-ID: <41CDD97A.10702@free.fr>
Date: Sat, 25 Dec 2004 22:19:54 +0100
From: Jerome Glisse <j.glisse@free.fr>
MIME-Version: 1.0
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: G5 AGP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am working on G5 agp uninorth and i am facing a strange problem.
I have my agpworking but the change i made seems to broke the fan
control, thus the fan start to go to their full speed shortly after i load
my uninorth driver.

Is fan control related in anyway to PCI or AGP ? :)

By the way i could not unload my module, kernel claim that is used
by someone even if no one (no graphics card module loaded) any clue ?

best,
Jerome Glisse
