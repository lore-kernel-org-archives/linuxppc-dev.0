Message-ID: <3DBEB5EB.7000003@embeddededge.com>
Date: Tue, 29 Oct 2002 11:23:07 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dc* (Data Cache)  instructions in mem*() and *_page() functions
 not used on 8xx
References: <IGEFJKJNHJDCBKALBJLLOEHIFHAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> It seems that even the newest 8xx chips still has problems. I did not expect that.

It may be the parts are working fine.  I long ago removed the code necessary
to detect the exception conditions when the cache instructions faulted, so
I wouldn't expect them to work properly.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
