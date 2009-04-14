Return-Path: <sunwx2001@hotmail.com>
Received: from bay0-omc2-s14.bay0.hotmail.com (bay0-omc2-s14.bay0.hotmail.com
	[65.54.246.150]) by ozlabs.org (Postfix) with ESMTP id 92BADDDFA0
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 21:08:13 +1000 (EST)
Message-ID: <BAY114-W4176A96E45AE37FB5FBE02AB7C0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_64a04098-c226-4268-8442-1a9c932f9932_"
From: SunNeo <sunwx2001@hotmail.com>
To: <sr@denx.de>, <linuxppc-dev@ozlabs.org>
Subject: RE: Help!Some memory doesn't work on PPC405Ex based board!
Date: Tue, 14 Apr 2009 11:08:12 +0000
In-Reply-To: <200904141123.02495.sr@denx.de>
References: <BAY114-W121B40A28E203154BC9209AB7F0@phx.gbl>
	<200904141123.02495.sr@denx.de>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_64a04098-c226-4268-8442-1a9c932f9932_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi, Stefan,

 

Thanks for your help.

 

My platform uses the MICRON MT47H256M8THN DDRII SDRAM and the DDRII SDRAM is soldered on the board.


As I said, my board was similar with "Kilauea" evb, so I created my configuration header file from Kilauea's at U-Boot. In the configuration file, register value for the DDR SDRAM controller is defined. But I have removed DDR autocalibraton related configuration from the configuration file, do you think this will cause any issues?

 

I'm not sure what you mean about "intensive memory test". I use "mm" cmd under U-Boot command prompt to modify value of high 512M memory, and this command works well.

 

About booting Linux, the kernel hangs at the same location. Always after this print info "<4>Mount-cache hash table entries: 512".


Best Regards,

Sun

 
> From: sr@denx.de
> To: linuxppc-dev@ozlabs.org
> Subject: Re: Help!Some memory doesn't work on PPC405Ex based board!
> Date: Tue, 14 Apr 2009 11:23:02 +0200
> CC: sunwx2001@hotmail.com
> 
> On Monday 13 April 2009, SunNeo wrote:
> > I'm porting Linux-2.6.29 on PPC405Ex based board, it's very similar to AMCC
> > "Kilauea" evb.
> >
> > In my board, two 512MB DDRII memory is connected to 2 ranks of the 405Ex
> > CPU. This 1GB memory works well at U-Boot-2009.01, but when I boot
> > Linux-2.6.29, the kernel hangs somewhere.
> 
> Does it just hang "somewhere", or always at the same location? A random hangup 
> could mean that you are having a memory problem (hardware, or wrong 
> initialization).
> 
> > What interesting is, if I 
> > configured the system to use only 512MB memory at U-Boot, the Linux can
> > boot normally.
> 
> Are you using DIMM's on your platform? Or soldered chips? Which memory 
> initialization code are you using in U-Boot? And which autocalibration code?
> 
> Did you do some intensive memory test?
> 
> Best regards,
> Stefan

_________________________________________________________________
打工，挣钱，买房子，快来MClub一起”金屋藏娇”！
http://club.msn.cn/?from=10
--_64a04098-c226-4268-8442-1a9c932f9932_
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
Hi, Stefan,<BR>
&nbsp;<BR>
Thanks for&nbsp;your help.<BR>
&nbsp;<BR>
My platform uses the MICRON MT47H256M8THN DDRII SDRAM and the DDRII SDRAM is soldered on the board.<BR>
<BR>As I said, my board&nbsp;was similar with "Kilauea" evb, so I created my configuration header file from Kilauea's at U-Boot. In the configuration file, register value for the DDR SDRAM controller is defined. But I have removed DDR autocalibraton related configuration from the configuration file, do you think this will cause any issues?<BR>
&nbsp;<BR>
I'm not sure what you mean about&nbsp;"intensive memory test". I&nbsp;use "mm" cmd&nbsp;under U-Boot command prompt to modify value of high 512M memory, and&nbsp;this command works well.<BR>
&nbsp;<BR>
About booting&nbsp;Linux, the kernel hangs at the same location. Always after this print info "&lt;4&gt;Mount-cache hash table entries: 512".<BR><BR>
Best Regards,<BR>
Sun<BR>
&nbsp;<BR>&gt; From: sr@denx.de<BR>&gt; To: linuxppc-dev@ozlabs.org<BR>&gt; Subject: Re: Help!Some memory doesn't work on PPC405Ex based board!<BR>&gt; Date: Tue, 14 Apr 2009 11:23:02 +0200<BR>&gt; CC: sunwx2001@hotmail.com<BR>&gt; <BR>&gt; On Monday 13 April 2009, SunNeo wrote:<BR>&gt; &gt; I'm porting Linux-2.6.29 on PPC405Ex based board, it's very similar to AMCC<BR>&gt; &gt; "Kilauea" evb.<BR>&gt; &gt;<BR>&gt; &gt; In my board, two 512MB DDRII memory is connected to 2 ranks of the 405Ex<BR>&gt; &gt; CPU. This 1GB memory works well at U-Boot-2009.01, but when I boot<BR>&gt; &gt; Linux-2.6.29, the kernel hangs somewhere.<BR>&gt; <BR>&gt; Does it just hang "somewhere", or always at the same location? A random hangup <BR>&gt; could mean that you are having a memory problem (hardware, or wrong <BR>&gt; initialization).<BR>&gt; <BR>&gt; &gt; What interesting is, if I <BR>&gt; &gt; configured the system to use only 512MB memory at U-Boot, the Linux can<BR>&gt; &gt; boot normally.<BR>&gt; <BR>&gt; Are you using DIMM's on your platform? Or soldered chips? Which memory <BR>&gt; initialization code are you using in U-Boot? And which autocalibration code?<BR>&gt; <BR>&gt; Did you do some intensive memory test?<BR>&gt; <BR>&gt; Best regards,<BR>&gt; Stefan<BR><br /><hr />把MSN装进手机，更多聊天乐趣等你挖掘！ <a href='http://mobile.msn.com.cn/' target='_new'>立刻下载！</a></body>
</html>
--_64a04098-c226-4268-8442-1a9c932f9932_--
