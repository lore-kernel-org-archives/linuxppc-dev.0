Message-ID: <4023E195.6050601@embeddededge.com>
Date: Fri, 06 Feb 2004 13:48:53 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Luca Risso <Luca.Risso@marconi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: head_8xx.S
References: <OFBF7609F1.4667B3D5-ONC1256E32.002AD496@uk.marconicomms.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Luca Risso wrote:

> With some further investigation I bypassed the problem removing the "tophys"...


There are some subtle VM changes in 2.6 that require code changes to the
TLB exception handlers and a few other places.  I know what they are, I just
don't have any active 8xx projects right now so I have to find time and boards
to get this done and tested.


Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
