Message-ID: <001501c45535$8aecd120$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20040618094003.1DC3EC13D3@atlas.denx.de>
Subject: Re: JTAG debuggers for Motorola 8xx/82xx/85xx 
Date: Fri, 18 Jun 2004 09:09:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for this information Wolfgang.  We've been trying to decide between
5200 and an 8xxx for a project and have gotten the distinct feeling that
5200 is somehow not from the same part of the company as 8xxx, and not
supported in the same way.  Do you know, do the 82xx or 85xx processors have
similar restrictions?

Mark Chambers

> Wolfgang wrote:
> So far we can only support the BDM interface; to implement  interface
> software  for  the  JTAG/COP  port  as  used  on  60x  based  systems
> (including the MPC5200) you need special documentation from Motorola,
> which is only available under a pretty strict NDA. The terms of  this
> NDA  prevent any open source implementation, so we cannot add this to
> GDB.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
