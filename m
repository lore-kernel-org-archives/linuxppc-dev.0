From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel ftp ?
Date: Mon, 16 Jul 2001 20:29:10 +0200
Message-Id: <20010716182910.21970@smtp.adsl.oleane.com>
In-Reply-To: 
 <Pine.LNX.4.33.0107161852360.10461-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.33.0107161852360.10461-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> Paul no longer maintains his own tree, his work is directly merged
>> in either bk _2_4 or _2_4_devel now.
>
>Which are hosted by montavista:
>rsync -avz --delete source.mvista.com::linuxppc_2_4 <directory>
>
>for the 'stable' 2.4 tree.

Those are mirrors, the main repository is hosted by bitmover
(ppc.bitkeeper.com). But those mirrors should work fine as well..

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
