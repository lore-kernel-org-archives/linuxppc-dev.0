Return-Path: <shriramjanardhan@yahoo.com>
Received: from web58514.mail.re3.yahoo.com (web58514.mail.re3.yahoo.com
	[68.142.236.197]) by ozlabs.org (Postfix) with SMTP id D1E9DDDFC6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 11:55:26 +1000 (EST)
Date: Wed, 5 Sep 2007 18:48:44 -0700 (PDT)
From: Shriram Janardhan <shriramjanardhan@yahoo.com>
Subject: Gianfar - MPC8541 - tx buffer overrun errors
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1999323389-1189043324=:90580"
Message-ID: <852639.90580.qm@web58514.mail.re3.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1999323389-1189043324=:90580
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

All,
   
  I am running 2.6.11 version of the kernel on MPC8541.  Have one of the TSECs configured at 100Mbps/Full Duplex.  The TSEC MAC is connected to a Marvell Ethernet switch MAC without any PHY in between.  MAC level flow control is enabled but no pause frames sent or received.
   
  I see a high number of transmit buffer overrun errors (tx_fifo_empty errors in the gianfar driver).  I don't have NAPI enabled.  In addition to other things, I was thinking of enabling NAPI and see if it helps - is there any downside to it??  Are there any other parameters that I could tweak to reduce/eliminate the overrun errors??
   
  Thanks,
  Shriram.
   

       
---------------------------------
Got a little couch potato? 
Check out fun summer activities for kids.
--0-1999323389-1189043324=:90580
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>All,</div>  <div>&nbsp;</div>  <div>I am running 2.6.11 version of the kernel on MPC8541.&nbsp;&nbsp;Have one of the TSECs configured at 100Mbps/Full Duplex.&nbsp; The TSEC MAC is connected to a Marvell Ethernet switch MAC without any PHY in between.&nbsp; MAC level flow control is enabled but no pause frames sent or received.</div>  <div>&nbsp;</div>  <div>I see a high number of transmit buffer overrun errors (tx_fifo_empty errors in the gianfar driver).&nbsp; I don't have NAPI enabled.&nbsp; In addition to other things, I was thinking of enabling NAPI and see if it helps - is there any downside to it??&nbsp; Are there any other parameters that I could tweak to reduce/eliminate the overrun errors??</div>  <div>&nbsp;</div>  <div>Thanks,</div>  <div>Shriram.</div>  <div>&nbsp;</div><p>&#32;
      <hr size=1>Got a little couch potato? <br>
Check out fun <a href="http://us.rd.yahoo.com/evt=48248/*http://search.yahoo.com/search?fr=oni_on_mail&p=summer+activities+for+kids&cs=bz">summer activities for kids.</a>
--0-1999323389-1189043324=:90580--
