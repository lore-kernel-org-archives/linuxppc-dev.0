Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s20.bay0.hotmail.com (bay0-omc2-s20.bay0.hotmail.com
	[65.54.246.156]) by ozlabs.org (Postfix) with ESMTP id 42BF4DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 23:51:19 +1100 (EST)
Message-ID: <BAY138-W21A6D92355C81BE1341628B2840@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_39306f19-d6e5-46ad-a562-9f4dfddc2424_"
From: MingLiu <eemingliu@hotmail.com>
To: schardt <g.schardt@fz-juelich.de>
Subject: RE: Bootloader & Flash
Date: Fri, 9 Nov 2007 12:51:18 +0000
In-Reply-To: <47344D70.4050308@fz-juelich.de>
References: <4731A8E3.4020909@fz-juelich.de>
	<BAY138-W14EEE9667CD669878D3BD0B28A0@phx.gbl>
	<47344D70.4050308@fz-juelich.de>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_39306f19-d6e5-46ad-a562-9f4dfddc2424_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi,
> - I have download the zImage.elf via the EDK flash loader> - The flash loader creates a bootloader, this is also running on start up :)
What you need to store in flash memory, is not the .elf file. Before you use EDK flash loader to burn your linux kernel in flash, .elf file should be transfered into .srec file, just like the below reminds you: SREC line is corrupted. 
 
> But ... It stops with an error-message after a few seconds:> > EDK Bootloader:> Bootloader: Processed (0x)000000b2 S-recordsERROR: SREC line is corrupted> > What now ?
Hopefully it helps. 
 
BR
Ming
_________________________________________________________________
Windows Live Spaces 中最年轻的成员！
http://miaomiaogarden2007.spaces.live.com/
--_39306f19-d6e5-46ad-a562-9f4dfddc2424_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>
Hi,<BR>
<BR>&gt; - I have download the zImage.elf via the EDK flash loader<BR>&gt; - The flash loader creates a bootloader, this is also running on start up :)<BR><BR>
What you need to store in flash memory, is not the .elf file. Before you use EDK flash loader to burn your linux kernel in flash, .elf file should be transfered into .srec file, just like the below reminds you: SREC line is corrupted. <BR>
&nbsp;<BR>
<BR>&gt; But ... It stops with an error-message after a few seconds:<BR>&gt; <BR>&gt; EDK Bootloader:<BR>&gt; Bootloader: Processed (0x)000000b2 S-recordsERROR: SREC line is corrupted<BR>&gt; <BR>&gt; What now ?<BR><BR>
Hopefully it helps. <BR>
&nbsp;<BR>
BR<BR>
Ming<BR><br /><hr />用 Windows Live Spaces 展示个性自我，与好友分享生活！  <a href='http://spaces.live.com/?page=HP' target='_new'>了解更多信息！</a></body>
</html>
--_39306f19-d6e5-46ad-a562-9f4dfddc2424_--
