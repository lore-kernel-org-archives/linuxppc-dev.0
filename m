Message-Id: <9908021902.AA36310@marc.watson.ibm.com>
To: Brad Midgley <brad@pht.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: test & set ppc assembly (libgcj vs. threads) 
In-Reply-To: Message from Brad Midgley <brad@pht.com>
   of "Mon, 02 Aug 1999 09:54:55 MDT." <Pine.LNX.3.95.990802095050.20647A-100000@pacific.pht.com>
Date: Mon, 02 Aug 1999 15:02:32 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The PowerPC User's Manuals provide an example in the appendix:

loop:	lwarx	    r5, 0, r3	   # load and reserve
	cmpwi	    r5, 0	   # compare to zero
	bne	    $+12	   # done if not equal
	stwcx.	    r4, 0, r3	   # try to store non-zero
	bne-	    loop	   # loop if lost reservation

r3 = address
r4 = new value
r5 = old value

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
