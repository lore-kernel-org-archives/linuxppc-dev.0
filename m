Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <s1331f30.037@EMAIL>
Date: Mon, 30 Aug 2004 12:26:11 +0530
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Does ext2 based on MTD acceptable for Embedded
	Development?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang ,

>> Is there an advantage to use ext2 instead of cramfs for read only fs?

> Boot time, as you don't need to uncompress the stuff.

Could you pls elaborate the choice of ex2 in the above scenario, instead of romfs. Was it to take advantage of the features that ext2 provides ?
Romfs should have had a better bootup time than ext2/jffs2/cramfs.




--
Rupesh S


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
