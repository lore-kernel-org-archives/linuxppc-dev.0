Return-Path: <MCarey@nearfield.com>
Received: from webmail.nearfield.com (webmail.nearfield.com [63.200.6.70])
	by ozlabs.org (Postfix) with ESMTP id F0A89679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Aug 2006 03:23:22 +1000 (EST)
Message-Id: <44D7146102000071000024CB@webmail.nearfield.com>
Date: Mon, 07 Aug 2006 10:22:25 -0700
From: "Michael Carey" <MCarey@nearfield.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: ELDK 3.1.1 support for x86_64 host architecture
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the help, your clue about linux32 was the key.

I simply used the command:

linux32 ./install -d /opt/eldk

and it worked.

I will continue to look for any missing components in my distribution =
install so I wont run into
this type of problem again.

Regards,
Michael Carey
