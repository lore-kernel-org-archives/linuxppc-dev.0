Date: Thu, 11 Mar 2004 19:05:02 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
Message-ID: <20040312030502.GA25644@gate.ebshome.net>
References: <20040312014800.GA25455@gate.ebshome.net> <405124A3.3040002@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <405124A3.3040002@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 11, 2004 at 09:46:59PM -0500, Dan Malek wrote:
>
> >Comments, suggestions are welcome.
>
> I think you should just write it as self modifying code :-)
> Write the instruction with the DCR number and just execute it.

And deal with locking and icache/dcache coherency ?

No, thanks :)

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
