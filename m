Message-ID: <405124A3.3040002@embeddededge.com>
Date: Thu, 11 Mar 2004 21:46:59 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
References: <20040312014800.GA25455@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin wrote:

> Comments, suggestions are welcome.

I think you should just write it as self modifying code :-)
Write the instruction with the DCR number and just execute it.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
