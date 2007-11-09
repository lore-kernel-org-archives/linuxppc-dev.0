Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s38.bay0.hotmail.com (bay0-omc2-s38.bay0.hotmail.com
	[65.54.246.174]) by ozlabs.org (Postfix) with ESMTP id E093EDDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Nov 2007 01:19:51 +1100 (EST)
Message-ID: <BAY138-W2395532B79F11BC1C09BD3B2840@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_475126ae-ba7f-4077-9a46-2c8fdc6aff60_"
From: MingLiu <eemingliu@hotmail.com>
To: schardt <g.schardt@fz-juelich.de>
Subject: RE: Bootloader & Flash
Date: Fri, 9 Nov 2007 14:19:50 +0000
In-Reply-To: <47346BB7.2000009@fz-juelich.de>
References: <4731A8E3.4020909@fz-juelich.de>
	<BAY138-W14EEE9667CD669878D3BD0B28A0@phx.gbl>
	<47344D70.4050308@fz-juelich.de>
	<BAY138-W21A6D92355C81BE1341628B2840@phx.gbl>
	<47346BB7.2000009@fz-juelich.de>
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

--_475126ae-ba7f-4077-9a46-2c8fdc6aff60_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Sometimes the simplest error is the most diffucult one to be found. :)
 
Have fun.
 
BR
Ming
 
> Date: Fri, 9 Nov 2007 15:16:23 +0100> From: g.schardt@fz-juelich.de> To: eemingliu@hotmail.com> CC: linuxppc-embedded@ozlabs.org> Subject: Re: Bootloader & Flash> > Argl :)> > The error was so ... simple.> The Flash device is broken. I take a new MiniModul and all things are> running.> > Thanks a lot> Georg> > MingLiu wrote:> > Hi,> >> > > - I have download the zImage.elf via the EDK flash loader> > > - The flash loader creates a bootloader, this is also running on> > start up :)> >> > What you need to store in flash memory, is not the .elf file. Before> > you use EDK flash loader to burn your linux kernel in flash, .elf file> > should be transfered into .srec file, just like the below reminds you:> > SREC line is corrupted.> >> >> > > But ... It stops with an error-message after a few seconds:> > >> > > EDK Bootloader:> > > Bootloader: Processed (0x)000000b2 S-recordsERROR: SREC line is> > corrupted> > >> > > What now ?> >> > Hopefully it helps.> >> > BR> > Ming> >> > ------------------------------------------------------------------------> > 用 Windows Live Spaces 展示个性自我，与好友分享生活！ 了解更多信息！> > <http://spaces.live.com/?page=HP>> > > > -----------------------------------------------------------------------------------------> -----------------------------------------------------------------------------------------> Forschungszentrum Jülich GmbH> 52425 Jülich> > Sitz der Gesellschaft: Jülich> Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498> Vorsitzende des Aufsichtsrats: MinDirig'in B"arbel Brumme-Bothe> Gesch"aftsführung: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. > Vorsitzender)> -----------------------------------------------------------------------------------------> -----------------------------------------------------------------------------------------
_________________________________________________________________
Windows Live Spaces 中最年轻的成员！
http://miaomiaogarden2007.spaces.live.com/
--_475126ae-ba7f-4077-9a46-2c8fdc6aff60_
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
Sometimes the simplest error is the most diffucult one to be found. :)<BR>
&nbsp;<BR>
Have fun.<BR>
&nbsp;<BR>
BR<BR>
Ming<BR>
&nbsp;<BR>
<BR><BR>&gt; Date: Fri, 9 Nov 2007 15:16:23 +0100<BR>&gt; From: g.schardt@fz-juelich.de<BR>&gt; To: eemingliu@hotmail.com<BR>&gt; CC: linuxppc-embedded@ozlabs.org<BR>&gt; Subject: Re: Bootloader &amp; Flash<BR>&gt; <BR>&gt; Argl :)<BR>&gt; <BR>&gt; The error was so ... simple.<BR>&gt; The Flash device is broken. I take a new MiniModul and all things are<BR>&gt; running.<BR>&gt; <BR>&gt; Thanks a lot<BR>&gt; Georg<BR>&gt; <BR>&gt; MingLiu wrote:<BR>&gt; &gt; Hi,<BR>&gt; &gt;<BR>&gt; &gt; &gt; - I have download the zImage.elf via the EDK flash loader<BR>&gt; &gt; &gt; - The flash loader creates a bootloader, this is also running on<BR>&gt; &gt; start up :)<BR>&gt; &gt;<BR>&gt; &gt; What you need to store in flash memory, is not the .elf file. Before<BR>&gt; &gt; you use EDK flash loader to burn your linux kernel in flash, .elf file<BR>&gt; &gt; should be transfered into .srec file, just like the below reminds you:<BR>&gt; &gt; SREC line is corrupted.<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt; &gt; But ... It stops with an error-message after a few seconds:<BR>&gt; &gt; &gt;<BR>&gt; &gt; &gt; EDK Bootloader:<BR>&gt; &gt; &gt; Bootloader: Processed (0x)000000b2 S-recordsERROR: SREC line is<BR>&gt; &gt; corrupted<BR>&gt; &gt; &gt;<BR>&gt; &gt; &gt; What now ?<BR>&gt; &gt;<BR>&gt; &gt; Hopefully it helps.<BR>&gt; &gt;<BR>&gt; &gt; BR<BR>&gt; &gt; Ming<BR>&gt; &gt;<BR>&gt; &gt; ------------------------------------------------------------------------<BR>&gt; &gt; 用 Windows Live Spaces 展示个性自我，与好友分享生活！ 了解更多信息！<BR>&gt; &gt; &lt;http://spaces.live.com/?page=HP&gt;<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; -----------------------------------------------------------------------------------------<BR>&gt; -----------------------------------------------------------------------------------------<BR>&gt; Forschungszentrum Jülich GmbH<BR>&gt; 52425 Jülich<BR>&gt; <BR>&gt; Sitz der Gesellschaft: Jülich<BR>&gt; Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498<BR>&gt; Vorsitzende des Aufsichtsrats: MinDirig'in B"arbel Brumme-Bothe<BR>&gt; Gesch"aftsführung: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. <BR>&gt; Vorsitzender)<BR>&gt; -----------------------------------------------------------------------------------------<BR>&gt; -----------------------------------------------------------------------------------------<BR><BR><br /><hr />用 Windows Live Spaces 展示个性自我，与好友分享生活！  <a href='http://spaces.live.com/?page=HP' target='_new'>了解更多信息！</a></body>
</html>
--_475126ae-ba7f-4077-9a46-2c8fdc6aff60_--
