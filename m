Message-ID: <4051D5EF.7040709@embeddededge.com>
Date: Fri, 12 Mar 2004 10:23:27 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.6 kernel on Sandpoint
References: <1079084120.691.16.camel@newt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian Cox wrote:

> I've got a Sandpoint X2.  I've ported linuxppc_2_4_devel to run on it,

Care to send out the patch?  I'll try to get it into the latest
2.4 tree.

> This should be the same on both X2 and X3 Sandpoints, leaving me curious
> as to whether the X3 works with the current tree.

Errr, not really.  The OpenPIC configuration for the two are quite
different.  Something may have been lost in translation.  My X3 has been
placed into active duty as the firewall/server, so I can help experiemnt
with the X2 if you jump start with a patch :-)

What processor are you running on the Sandpoint?


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
