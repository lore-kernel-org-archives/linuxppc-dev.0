Message-ID: <3AFEE17F.6A59CB1F@acm.org>
Date: Sun, 13 May 2001 12:33:19 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: linxuppc-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_5 source tree (and others)
References: <20010510114909.B28206@opus.bloom.county>
	 <200105101946.f4AJks3441196@saturn.cs.uml.edu> <20010510144442.A29513@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


bk trees: http://www.fsmlabs.com/linuxppcbk.html

Are these trees designed to work "out of the box" on boards such as the
Walnut?

When configuring I don't see any options for the specific 405GP ethernet
for instance.

Also, do I need a password or something to get the devel tree?  Am I
allowed to get to the devel tree?

As per the instructions on the page (adding -azv):

$ rsync -azv bitkeeper.fsmlabs.com::linuxppc_2_4_devel
linuxppc_2_4_devel
@ERROR: Unknown module 'linuxppc_2_4_devel'
$ rsync bitkeeper.fsmlabs.com::
linuxppc_2_2
linuxppc_2_4
$

Thanks,
Ira Weiny

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
