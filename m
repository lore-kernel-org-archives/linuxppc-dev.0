Date: Mon, 14 May 2001 19:40:03 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Ira Weiny <iweiny@acm.org>
Cc: linxuppc-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_5 source tree (and others)
Message-ID: <20010514194003.C12060@ftsoj.fsmlabs.com>
References: <20010510114909.B28206@opus.bloom.county> <200105101946.f4AJks3441196@saturn.cs.uml.edu> <20010510144442.A29513@opus.bloom.county> <3AFEE17F.6A59CB1F@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AFEE17F.6A59CB1F@acm.org>; from iweiny@acm.org on Sun, May 13, 2001 at 12:33:19PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nope.  The _devel tree does mean it's a development tree with experimental
changes in it.  It will sometimes work, sometimes not.

The _2_4 tree will contain the changes we're more confident in and have
tested somewhat.

Only the _2_4_devel tree has the Walnut changes right now.

} Are these trees designed to work "out of the box" on boards such as the
} Walnut?
}
} When configuring I don't see any options for the specific 405GP ethernet
} for instance.

For read-only access, no password is necessary.  I fixed the rsync problem,
it's working now.

} Also, do I need a password or something to get the devel tree?  Am I
} allowed to get to the devel tree?
}
} As per the instructions on the page (adding -azv):
}
} $ rsync -azv bitkeeper.fsmlabs.com::linuxppc_2_4_devel
} linuxppc_2_4_devel
} @ERROR: Unknown module 'linuxppc_2_4_devel'
} $ rsync bitkeeper.fsmlabs.com::
} linuxppc_2_2
} linuxppc_2_4
} $

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
