Message-ID: <3F0BA671.1050900@embeddededge.com>
Date: Wed, 09 Jul 2003 01:21:53 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Dean Matsen <deanmatsen@earthlink.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with  971/972
 chips
References: <3F0B7B28.7040902@earthlink.net> <5.1.0.14.2.20030708195315.038110e8@mail.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin wrote:

> It usually means that your hw lacks pull-up on MII MDIO line.

Yep, and even when PHYs indicate they have internal pull-ups, either
they don't or they aren't sufficient.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
