From: benh@kernel.crashing.org
To: "Mark A. Greer" <mgreer@mvista.com>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Wed, 27 Mar 2002 19:40:11 +0100
Message-Id: <20020327184011.1527@mailhost.mipsys.com>
In-Reply-To: <3CA1F048.6E1CD277@mvista.com>
References: <3CA1F048.6E1CD277@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Yeah, that's right, I messed up.  So what should be done for the nested ones?
>What is we use the BI_DEVICE as a quasi-BI_FIRST and then add a BI_LAST
>to each
>nested one?  This is what it would look like:

Any reason why BI_LAST has those 4 bytes of data set to 0, why not
just BI_LAST size=0 and no data ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
