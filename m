Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s22.bay0.hotmail.com (bay0-omc1-s22.bay0.hotmail.com
	[65.54.246.94]) by ozlabs.org (Postfix) with ESMTP id D116BDDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 05:36:45 +1100 (EST)
Message-ID: <BAY138-W36D809216B04A0501903CEB2F50@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_2be88b15-1f86-450f-aba6-342fff625bfe_"
From: MingLiu <eemingliu@hotmail.com>
To: Robert Woodworth <rwoodworth@securics.com>
Subject: RE: xilinx Ml405 NFS mount problem
Date: Tue, 1 Apr 2008 18:36:43 +0000
In-Reply-To: <1207068618.4830.60.camel@PisteOff>
References: <BAY138-W7044A57F2CF37F5DB50F6B2F50@phx.gbl>
	<20080401142910.5BFD038005F@mail141-dub.bigfish.com>
	<BAY138-W40E4E945BA6E40EABEE811B2F50@phx.gbl>
	<1207068618.4830.60.camel@PisteOff>
MIME-Version: 1.0
Cc: John Linn <john.linn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_2be88b15-1f86-450f-aba6-342fff625bfe_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear Robert> Let me guess. > You are using a base system from "Base System Builder Wizard"?> EDK 9.2i. Default syntheses/P&R options.
I am using EDK 10.1 evaluation version (60 days) from Xilinx. I don't have experience on EDK 9.2 and previously I was working on EDK 8.2. 
> I have seen a massive packet loss problems on my ML403 and two other> boards I have with an FX60.> > This is probably a hardware problem.> Xilinx has acknowledged an LL_TEMAC problem to me but has not provided a> fix. I have heard that things are better with EDK/ISE-10.1 but I have> not tested it.
I got the following message from my NFS server PC: 
 Apr  1 15:08:34 linux kernel: UDP: bad checksum. From 192.168.0.4:839 to
192.168.0.3:627 ulen 48
Apr  1 15:08:40 linux kernel: UDP: bad checksum. From 192.168.0.4:839 to
192.168.0.3:627 ulen 48
Apr  1 15:08:49 linux kernel: UDP: bad checksum. From 192.168.0.4:839 to
192.168.0.3:627 ulen 48
Apr  1 15:13:23 linux kernel: nfsd: last server has exited
Apr  1 15:13:23 linux kernel: nfsd: unexporting all filesystems
Apr  1 15:13:23 linux rpc.mountd: Caught signal 15, un-registering and
exiting.
Apr  1 15:13:24 linux kernel: NFSD: Using /var/lib/nfs/v4recovery as the
NFSv4 state recovery directory
Apr  1 15:13:24 linux kernel: NFSD: recovery directory
/var/lib/nfs/v4recovery doesn't exist
Apr  1 15:13:24 linux kernel: NFSD: starting 90-second grace period
Apr  1 16:02:57 linux syslog-ng[3700]: STATS: dropped 0
Apr  1 17:02:57 linux syslog-ng[3700]: STATS: dropped 0
Apr  1 18:02:58 linux syslog-ng[3700]: STATS: dropped 0
I shows "UDP bad checksum" from my board to the PC. I don't know if it has something to do with the package loss problem. 
 > The vendor of one of my boards (Pico) has fixed the problem on the FX60> by highly constraining the timing of the LL_TEMAC in map/PR. On my> ML403 I used similar constraints and it fixed the problem, but only if> the device is plugged into a GigE switch. The problem is still there> with the same .bit file on a 100-T switch. 
I connect the board with the PC point-to-point with gigabit ethernet. It should be even better than a Gigabit switch, right? 
 
BR
Ming
_________________________________________________________________
Windows Live Photo gallery 数码相机的超级伴侣，轻松管理和编辑照片，还能制作全景美图！
http://get.live.cn/product/photo.html
--_2be88b15-1f86-450f-aba6-342fff625bfe_
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
Dear Robert<BR><BR>&gt; Let me guess. <BR>&gt; You are using a base system from "Base System Builder Wizard"?<BR>&gt; EDK 9.2i. Default syntheses/P&amp;R options.<BR><BR>
I am using EDK 10.1 evaluation version (60 days) from Xilinx. I don't have experience on EDK 9.2 and previously I was working on EDK 8.2. <BR>
<BR>&gt; I have seen a massive packet loss problems on my ML403 and two other<BR>&gt; boards I have with an FX60.<BR>&gt; <BR>&gt; This is probably a hardware problem.<BR>&gt; Xilinx has acknowledged an LL_TEMAC problem to me but has not provided a<BR>&gt; fix. I have heard that things are better with EDK/ISE-10.1 but I have<BR>&gt; not tested it.<BR><BR>
I got the following message from my NFS server PC: <BR>
&nbsp;<BR><PRE>Apr  1 15:08:34 linux kernel: UDP: bad checksum. From 192.168.0.4:839 to
192.168.0.3:627 ulen 48
Apr  1 15:08:40 linux kernel: UDP: bad checksum. From 192.168.0.4:839 to
192.168.0.3:627 ulen 48
Apr  1 15:08:49 linux kernel: UDP: bad checksum. From 192.168.0.4:839 to
192.168.0.3:627 ulen 48
Apr  1 15:13:23 linux kernel: nfsd: last server has exited
Apr  1 15:13:23 linux kernel: nfsd: unexporting all filesystems
Apr  1 15:13:23 linux rpc.mountd: Caught signal 15, un-registering and
exiting.
Apr  1 15:13:24 linux kernel: NFSD: Using /var/lib/nfs/v4recovery as the
NFSv4 state recovery directory
Apr  1 15:13:24 linux kernel: NFSD: recovery directory
/var/lib/nfs/v4recovery doesn't exist
Apr  1 15:13:24 linux kernel: NFSD: starting 90-second grace period
Apr  1 16:02:57 linux syslog-ng[3700]: STATS: dropped 0
Apr  1 17:02:57 linux syslog-ng[3700]: STATS: dropped 0
Apr  1 18:02:58 linux syslog-ng[3700]: STATS: dropped 0</PRE>
I shows "UDP bad checksum" from my board to the PC. I don't know if it has something to do with the package loss problem. <BR>
&nbsp;<BR>&gt; The vendor of one of my boards (Pico) has fixed the problem on the FX60<BR>&gt; by highly constraining the timing of the LL_TEMAC in map/PR. On my<BR>&gt; ML403 I used similar constraints and it fixed the problem, but only if<BR>&gt; the device is plugged into a GigE switch. The problem is still there<BR>&gt; with the same .bit file on a 100-T switch. <BR><BR>
I connect the board with the PC point-to-point with gigabit ethernet. It should be even better than a Gigabit switch, right? <BR>
&nbsp;<BR>
BR<BR>
Ming<BR><br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://messenger.live.cn/' target='_new'>立即体验！</a></body>
</html>
--_2be88b15-1f86-450f-aba6-342fff625bfe_--
