Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Oliver Fuchs" <olivers.lists@gmx.net>
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 27 Aug 2004 12:05:44 +0200
MIME-Version: 1.0
Subject: Re: Does ext2 based on MTD acceptable for Embedded Development? 
Message-ID: <412F2398.313.E2BE91@localhost>
In-reply-to: <20040827074002.58692C109F@atlas.denx.de>
References: Your message of "Fri, 27 Aug 2004 09:08:23 +0200." <412EFA07.27872.405FEB@localhost> 
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


From:           	Wolfgang Denk <wd@denx.de>

> > I would not use ext2 on MTD.
>
> We do, and it works perfect. You just want to make sure to  mount  it
> read-only.
Is there an advantage to use ext2 instead of cramfs for read only fs?

Regards,
Oliver


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
