Date: Thu, 17 Oct 2002 17:11:53 +0100 (BST)
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IMMR for fads mpc860
In-Reply-To: <20021017100442.71539.qmail@web8005.mail.in.yahoo.com>
Message-ID: <Pine.LNX.4.44.0210171709430.2469-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 17 Oct 2002, rekha gvv wrote:

>
> Hello,
> I would like to know what is the physical address of
> Internal memory mapped register for the fads mpc860
> board ..

The default value of the IMMR is defined by the Hard Reset Configuration
Word.  This is explained in the UM.

But if you just want to read it - do this from kernel space:

int val = mfspr(IMMR);

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
