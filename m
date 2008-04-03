Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s41.bay0.hotmail.com (bay0-omc3-s41.bay0.hotmail.com
	[65.54.246.241]) by ozlabs.org (Postfix) with ESMTP id 5CC68DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 19:28:54 +1100 (EST)
Message-ID: <BAY138-W45D7625ED50533D8D2680BB2F70@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_1b3bec81-453b-4902-ae11-0a52fa7824be_"
From: MingLiu <eemingliu@hotmail.com>
To: John Bonesio <john.bonesio@xilinx.com>, Johann Baudy <johaahn@gmail.com>
Subject: RE: Xilinx LLTEMAC driver issues
Date: Thu, 3 Apr 2008 08:28:53 +0000
In-Reply-To: <20080403003200.CB2BF1968046@mail103-sin.bigfish.com>
References: <20080329125416.B09261AD8051@mail119-sin.bigfish.com>
	<000601c8931f$e1d549a0$a57fdce0$@se>
	<7e0dd21a0804020020s66a091ferfbbf4142adcd84ae@mail.gmail.com>
	<20080403003200.CB2BF1968046@mail103-sin.bigfish.com>
MIME-Version: 1.0
Cc: John Linn <john.linn@xilinx.com>, git <git@xilinx.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_1b3bec81-453b-4902-ae11-0a52fa7824be_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear all,
> The change with the extra parenthesis (in the patch starting with line 133) seems unecessary. I looked at the XLlDma_mBdWrite macro and it appeared to have the correct use of parethesis in the implementation.> So, assuming there's nothing subtle that I missed, it's not needed. However, it does no harm either.
However it really helps after I tried this patch. So there should be some difference after it is used. 
 
One more question, does this mean that the problem is not on the hardware timing, but the device driver? 
 
BR
Ming
_________________________________________________________________
用手机MSN聊天写邮件看空间，无限沟通，分享精彩！
http://mobile.msn.com.cn/
--_1b3bec81-453b-4902-ae11-0a52fa7824be_
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
Dear all,<BR>
<BR>&gt; The change with the extra parenthesis (in the patch starting with line 133) seems unecessary. I looked at the XLlDma_mBdWrite macro and it appeared to have the correct use of parethesis in the implementation.<BR>&gt; So, assuming there's nothing subtle that I missed, it's not needed. However, it does no harm either.<BR><BR>
However it really helps after I tried this patch. So there should be some difference after it is used. <BR>
&nbsp;<BR>
One more question, does this mean that the problem is not on the hardware timing, but the device driver? <BR>
&nbsp;<BR>
BR<BR>
Ming<BR><br /><hr />Windows Live Writer，支持离线撰写博客内容，随时随地想写就写。 <a href='http://get.live.cn/product/writer.html' target='_new'>立即使用！</a></body>
</html>
--_1b3bec81-453b-4902-ae11-0a52fa7824be_--
