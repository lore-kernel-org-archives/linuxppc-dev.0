Message-ID: <39EB8A67.E2F9C023@mvista.com>
Date: Mon, 16 Oct 2000 16:08:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: If not CONFIG_ALL_PPC, you're broken
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've haven't been paying attention to this but it seems as though any
platform that doesn't fit in CONFIG_ALL_PPC doesn't build anymore.

I've intentionally stayed back from the bleeding edge so I don't run
into these types of problems.  However, now I'm ready to bring some
things up to the latest version and release to the world.  Problem is,
some of the stuff I depend on is  broken and has been for some time as I
understand it.

I guess I was hoping that enough people were tracking the latest changes
that things wouldn't stay broken for too long.  Yes, I know, I am lazy
and should contribute more.  Anyway, I think we all need to pay closer
attention to the changes that are being put in, including me.

What's the best way to get the other platforms working again?

Mark

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
