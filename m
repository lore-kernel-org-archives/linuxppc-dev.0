Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s30.bay0.hotmail.com (bay0-omc3-s30.bay0.hotmail.com
	[65.54.246.230]) by ozlabs.org (Postfix) with ESMTP id AED44DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 19:11:52 +1000 (EST)
Message-ID: <BAY138-W368A781D323F0E5E4D0BF3B2CF0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_427c7534-89fb-4e9b-89fd-fcb20860152c_"
From: MingLiu <eemingliu@hotmail.com>
To: Dave Cogley <dcogley@uslinc.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: mmap problem in device driver and application program.
Date: Tue, 13 May 2008 09:11:50 +0000
In-Reply-To: <1210366552.3755.21.camel@localhost.localdomain>
References: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl>
	<1210266109.3755.8.camel@localhost.localdomain>
	<BAY138-W36C7249F532D111A1DC508B2D00@phx.gbl>
	<1210366552.3755.21.camel@localhost.localdomain>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_427c7534-89fb-4e9b-89fd-fcb20860152c_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear Dave,
> If you are using memory that is not under the kernel's memory management> you will need to use something other than remap_pfn_range.> 
Happenly and unfortunately we are using the memory space out of the control from the kernel. We have 2GB memory on the board and only 64(or 32) MB is reserved for the kernel. The rest large space is for the data buffering or LUT use. In my question, the LUT memory is located in the rest part rather than the kernel memory area. 
 
Any more suggestion on how to mmap this LUT area? Any idea will be valuable for a beginner like me. Thanks in advance. 
 
BR
Ming
_________________________________________________________________
新年换新颜，快来妆扮自己的MSN给心仪的TA一个惊喜！
http://im.live.cn/emoticons/?ID=18
--_427c7534-89fb-4e9b-89fd-fcb20860152c_
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
Dear Dave,<BR>
<BR>&gt; If you are using memory that is not under the kernel's memory management<BR>&gt; you will need to use something other than remap_pfn_range.<BR>&gt; <BR><BR>
Happenly and unfortunately we are using the memory space out of the control from the kernel. We have 2GB memory on the board and only 64(or 32) MB is reserved for the kernel. The rest large space is for the data buffering or LUT use. In my question, the LUT memory is located in the rest part rather than the kernel memory area. <BR>
&nbsp;<BR>
Any more suggestion on how to mmap this LUT area? Any idea will be valuable for a beginner like me. Thanks in advance. <BR>
&nbsp;<BR>
BR<BR>
Ming<BR><br /><hr />“七件武器，七种完美” <a href='http://get.live.cn' target='_new'>立刻体验！</a></body>
</html>
--_427c7534-89fb-4e9b-89fd-fcb20860152c_--
