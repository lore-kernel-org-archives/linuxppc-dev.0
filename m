Return-Path: <mjoshi_blr@yahoo.com>
Received: from web34701.mail.mud.yahoo.com (web34701.mail.mud.yahoo.com
	[209.191.68.150]) by ozlabs.org (Postfix) with SMTP id 8E9F568459
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 03:01:17 +1000 (EST)
Message-ID: <20051003165435.70417.qmail@web34701.mail.mud.yahoo.com>
Date: Mon, 3 Oct 2005 09:54:35 -0700 (PDT)
From: Manish Joshi <mjoshi_blr@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1217191327-1128358475=:69304"
Subject: MPC 8260/70 MCC SI Clocking and TSA Sync
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1217191327-1128358475=:69304
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
 
I am trying to bring up MCC (Multi Channel Communication controller) on MPC8270 board for T1/E1.
The overall configuration looks fine since I am able to have a communication properly if I do a T1 Cross over Loopback and tx/rx HDLC data.
The things do not work smoothly if I connect my T1 line with an external device and start HDLC.
I am seeing 'NO' (Rx Non-Octet Alligned Frame) errors in my rx buffers. Sometimes I also see Rx abort errors.
I do not see this issue on the tx side i.e the external device does not report any of these when I tx HDLC data to it.
 
Does anybody have any experience dealing with this ? 
 
As far as clocking and sync with TSA is concerned, I have just configured 
CMXSI2CR register with 0x00 ( I have only TDM2A driven by CLK1) and nothing else. 

Do I need to do something more for clocking etc? Also I am doing this before SI initialisation.

I will also try doing it just after TDM init and see if it helps.

Please help.

 

Thanks,

-Manish

 

 

 

 


		
---------------------------------
Yahoo! for Good
 Click here to donate to the Hurricane Katrina relief effort. 
--0-1217191327-1128358475=:69304
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am trying to bring up MCC (Multi Channel Communication controller)&nbsp;on MPC8270 board for T1/E1.</DIV>
<DIV>The overall configuration looks fine since I am able to have a communication properly if I do a T1 Cross over Loopback and tx/rx HDLC&nbsp;data.</DIV>
<DIV>The things do not work smoothly if I connect my T1 line with an external device and start HDLC.</DIV>
<DIV>I am seeing 'NO' (Rx Non-Octet Alligned Frame) errors in my rx buffers. Sometimes I also see Rx abort errors.</DIV>
<DIV>I do not see this issue on the tx side i.e the external device does not report any of these when I tx HDLC data to it.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Does anybody have any experience dealing with this ? </DIV>
<DIV>&nbsp;</DIV>
<DIV>As far as clocking and sync with TSA is concerned, I have just configured <FONT size=2>
<P>CMXSI2CR register with 0x00 (&nbsp;I have only TDM2A driven by CLK1) and nothing else. </P>
<P>Do I need to do something more for clocking etc? Also I am doing this before SI initialisation.</P>
<P>I will also try doing it just after TDM init and see if it helps.</P>
<P>Please help.</P>
<P>&nbsp;</P>
<P>Thanks,</P>
<P>-Manish</P>
<P>&nbsp;</P>
<P>&nbsp;</P>
<P>&nbsp;</P>
<P></FONT>&nbsp;</P></DIV><p>
		<hr size=1>Yahoo! for Good<br> 
<a href="http://store.yahoo.com/redcross-donate3/">Click here to donate</a> to the Hurricane Katrina relief effort. 

--0-1217191327-1128358475=:69304--
