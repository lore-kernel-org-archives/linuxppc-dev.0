Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5ADFC67CD0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 22:28:04 +1100 (EST)
Message-Id: <20061211230208.526233000@sipsolutions.net>>
Date: Tue, 12 Dec 2006 00:02:08 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 0/3] experimental G5 powermac suspend implementation
Mime-Version: 1.0
Cc: Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org,
	Michael Buesch <mb@bu3sch.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a rather hacky suspend implementation for G5s.

I'm only posting it for the fun of it and because it makes no sense to
continue sitting on it (I've had parts of this code more than half a year
ago...)

Don't blame me if it breaks your machine, filesystems or similar :)

johannes
