Message-ID: <3CD7F88A.5000205@embeddededge.com>
Date: Tue, 07 May 2002 11:53:46 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 8260 and skb implementation
References: <NCBBIINEHIPFGJPLBEIFKEJPDGAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen Curtis wrote:

> We have an 8260 based product and have many production boards with pre-B.3
> rev processors. As mentioned on this list, we had to modify all CP related
> communications to operate from local RAM to avoid lock-up problems.

I don't remember why you had to do this........

> ....Has anyone
> considered moving the SKB memory into local RAM as well? ....

Yes, except I have never had a platform with a working local bus interface
where this would work.

> ..... we
> have 8MB of local RAM. Is this a reasonable amount of memory for SKB..

Should be plenty.  If you have this much data backed up in the protocol
stack you have big trouble elsewhere.  The only failure mode is the
driver will start dropping receive packets if it can't allocate a buffer.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
