Return-Path: <vcppjava@yahoo.com>
Received: from web33205.mail.mud.yahoo.com (web33205.mail.mud.yahoo.com
	[209.191.69.153]) by ozlabs.org (Postfix) with SMTP id 62C8267CB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 12:00:21 +1100 (EST)
Message-ID: <20061108005340.16693.qmail@web33205.mail.mud.yahoo.com>
Date: Tue, 7 Nov 2006 16:53:40 -0800 (PST)
From: john ke <vcppjava@yahoo.com>
Subject: IDMA on MPC82xx
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1315510965-1162947220=:16685"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1315510965-1162947220=:16685
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Any one who has any experience when using IDMA on mpc82xx? 
Currently, the status what I have got is, memory-to-memory mode, both Data bus had been set to 60x-bus,which means DDTB and SDTB are working on 60x-bus. if set DMA_WRAP in DCM as 64-byte, SS_MAX,STS and DTS in (IDMA Parameter RAM) all to 32 Bytes, there woking good!
But if set DMA_WRAP more than 64-byte(i.e 256-bytes)  ,SS_MAX,STS and DTS in (IDMA Parameter RAM) all to 7*32 Bytes when WRAP = 256 . then got some issues:
1.some bytes in a packet had been changed oddly. for example if  some bytes in the packet is "20 0f 17 2c...." after 
IDMA transmission , the bytes will be changed as "20 1d 17 2c", there is a slightly different with "17" and "1d".
2. some bytes had been swapped , for example "20 0f 17 2c" , after transmission , the bytes in packet was "2c 17 0f 20".
any ideas?
 
 
---------------------------------
Sponsored Link

Try Netflix today! With plans starting at only $5.99 a month what are you waiting for?
--0-1315510965-1162947220=:16685
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Any one who has any experience when using IDMA on mpc82xx? <br>Currently, the status what I have got is, memory-to-memory mode, both Data bus had been set to 60x-bus,which means DDTB and SDTB are working on 60x-bus. if set DMA_WRAP in DCM as 64-byte, SS_MAX,STS and DTS in (IDMA Parameter RAM) all to 32 Bytes, there woking good!<br>But if set DMA_WRAP more than 64-byte(i.e 256-bytes)  ,SS_MAX,STS and DTS in (IDMA Parameter RAM) all to 7*32 Bytes when WRAP = 256 . then got some issues:<br>1.some bytes in a packet had been changed oddly. for example if&nbsp; some bytes in the packet is "20 0f 17 2c...." after <br>IDMA transmission , the bytes will be changed as "20 1d 17 2c", there is a slightly different with "17" and "1d".<br>2. some bytes had been swapped , for example "20 0f 17 2c" , after transmission , the bytes in packet was "2c 17 0f 20".<br>any ideas?<br> <p>&#32;


<hr size=1>Sponsored Link<br><br>
<a href="http://clk.atdmt.com/NFX/go/yhxxxnfx0020000913nfx/direct/01/">Try Netflix today! With plans starting at only $5.99 a month what are you waiting for?</a>
--0-1315510965-1162947220=:16685--
