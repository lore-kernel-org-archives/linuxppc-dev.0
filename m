Message-ID: <3C908A1A.3070102@cambridgebroadband.com>
Date: Thu, 14 Mar 2002 11:31:38 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Formatting JFFS2 Flash
References: <A1C99F4731CAD111BA5400A024FC3B0CBE047C@ESBILMA01EDCGE>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> 	2.- cp jffs2.image /dev/mtd0
>
> and then mounting it into the system.
>

This looks wrong.  You should use

cat jffs2.image > /dev/mtd0

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
