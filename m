Message-ID: <3DEE781C.5070208@embeddededge.com>
Date: Wed, 04 Dec 2002 16:48:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS root woes: No init found
References: <200212041635.31861.waite@skycomputers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Waite wrote:

> ...Then I get the message No init found.

First, try using something simple like /bin/bash as your init program.
Trying to start up the init program relies on lots of things being
present in the file system.  If the program starts, and then exits,
you still get this message.

Just use a trivial, simple file system to get started.  A shell,
couple of commands and minimal libraries are easier to debug.

Good luck :-)

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
