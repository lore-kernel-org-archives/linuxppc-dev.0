Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Oliver Fuchs" <olivers.lists@gmx.net>
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 27 Aug 2004 09:08:23 +0200
MIME-Version: 1.0
Subject: Re: Does ext2 based on MTD acceptable for Embedded Development?
Message-ID: <412EFA07.27872.405FEB@localhost>
In-reply-to: <20040826101003.70248.qmail@web15605.mail.cnb.yahoo.com>
References: <20040816162120.6403FC109F@atlas.denx.de>
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

From:           	Song Sam <samlinuxppc@yahoo.com.cn>

> still want to consult with you such a question.Dose
> ext2 filesystem besed on MTD a acceptable option?

I would not use ext2 on MTD.
JFFS2 is much better for that purpose for in contrast to ext2, it is
power down reliable and performs wear leveling.

Regards,
Oliver


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
