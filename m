Return-Path: <hgang.m@hotmail.com>
Received: from col0-omc4-s8.col0.hotmail.com (col0-omc4-s8.col0.hotmail.com
	[65.55.34.210]) by ozlabs.org (Postfix) with ESMTP id 84820DDF66
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 19:55:43 +1100 (EST)
Message-ID: <COL104-W798BDB8F0AC936464E80D7EB9E0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_11d961f8-8821-4839-8948-bd38749fff34_"
From: AA <hgang.m@hotmail.com>
To: <sachinp@in.ibm.com>, <sfr@canb.auug.org.au>, <linux-kernel@zh-kernel.org>
Subject: where should I map 0x8000,0000 ~ 0xfc00,0000 to ?
Date: Wed, 11 Mar 2009 16:53:40 +0800
In-Reply-To: <COL104-W4161BE11903ACD5CE8A80EB9E0@phx.gbl>
References: <20090310195534.8f8f3c7a.sfr@canb.auug.org.au>
	<49B67552.5070307@in.ibm.com>
	<COL104-W4161BE11903ACD5CE8A80EB9E0@phx.gbl>
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_11d961f8-8821-4839-8948-bd38749fff34_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi all
 I am newer to linux.
 
 My board is MPC750+MPC106, and I use MAPB for MPC106.
 Due to 106 datasheet, 
 0x8000,0000 -- 0xFC00,0000 for PCI memory space.
 
 As you know, user space is 0~0xbfff,ffff (3G). 
 0xc000,0000 ~ 0xffff,ffff(1G) is for kernel.

 And my question is:
 1) where should I map this address space to ?
 2) user application can access this address space directly?
 
 
_________________________________________________________________
梦幻K图，百变造型，让你的照片与众不同，快来MClub试试吧！
http://club.msn.cn/?form=3
--_11d961f8-8821-4839-8948-bd38749fff34_
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
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
Hi all<BR>&nbsp;I am newer to linux.<BR>&nbsp;<BR> My board is MPC750+MPC106, and I use MAPB for MPC106.<BR>&nbsp;Due to 106 datasheet,&nbsp;<BR> 0x8000,0000 -- 0xFC00,0000 for PCI memory space.<BR>&nbsp;<BR> As you know, user space is 0~0xbfff,ffff (3G).&nbsp;<BR> 0xc000,0000 ~ 0xffff,ffff(1G) is for kernel.<BR><BR>&nbsp;And my question is:<BR>&nbsp;1) where should I map this address space to ?<BR>&nbsp;2) user application can access this address space directly?<BR>&nbsp;<BR> <br /><hr />把MSN装进手机，更多聊天乐趣等你挖掘！ <a href='http://mobile.msn.com.cn/' target='_new'>立刻下载！</a></body>
</html>
--_11d961f8-8821-4839-8948-bd38749fff34_--
