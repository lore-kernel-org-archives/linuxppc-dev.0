Message-ID: <3E3AB650.5080108@embeddededge.com>
Date: Fri, 31 Jan 2003 12:45:52 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: gopi@india.tejasnetworks.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc 8260 performance..
References: <NCBBIINEHIPFGJPLBEIFKEKKEBAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:

 > gopi wrote:
>>In this case, the system can potentially be interrupted too...


> Sounds like a HW design issue you need to address. Perhaps it would be
> better to interrupt on buffer full ....

High performance routers don't interrupt at all, typically have
carefully hand-tuned algorithms to maximize the use of processor cache
for instructions and ensure the data bus is aligned and bursting data.
Linux has been used in such designs, but the network drivers are
written specific to those applications.  The Linux network drivers are
examples of workstation connections and network layer interfaces, but
aren't suitable for these specialty applications.  They are suitable
for functional testing, but not for high performance routing.

An 8260 can process lots of communication data, obviously its performance
is totally dependent upon the software design and implemetation.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
