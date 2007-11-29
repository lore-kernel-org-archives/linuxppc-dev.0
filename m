Return-Path: <adolnikov@ru.mvista.com>
Received: from barber.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC22DDDDE6
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 02:07:00 +1100 (EST)
Received: from barber.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by barber.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id lATF7ReQ014734
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 18:07:27 +0300
Received: (from root@localhost)
	by barber.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id lATF7RT1014733
	for linuxppc-dev@ozlabs.org; Thu, 29 Nov 2007 18:07:27 +0300
Date: Thu, 29 Nov 2007 18:07:26 +0300
From: Andrei Dolnikov <adolnikov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] PowerPC 74xx: Add Emerson Katana Qp support
Message-ID: <20071129150726.GA13751@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello folks,

The following patch sequence is Emerson KatanaQp board support reworked after initial review/discussion.
The patches are incremental to minor mv64x60 code fixups sent by
Mark A. Greer on 11/08/07.

Let me know if you think that some updates/changes needed.


As for Vitaly's and Arnd's questions:

Vitaly Bordug wrote:
>> +		clock-frequency = <7f28155>;		/*
>> 133.333333 MHz */
>This should be updated somewhere in fw or bootwrapper.. Or is it hardcoded
>value that is not going to change?
Yep, it is :)

About cfi-flash: I leave this code as is, according to Benjamin comment.

Thanks,
Andrei.
