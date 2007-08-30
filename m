Return-Path: <melinda.develey70@yahoo.com>
Received: from web63906.mail.re1.yahoo.com (web63906.mail.re1.yahoo.com
	[69.147.97.121]) by ozlabs.org (Postfix) with SMTP id CDD84DDE39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 16:30:24 +1000 (EST)
Date: Wed, 29 Aug 2007 23:30:22 -0700 (PDT)
From: melinda develey <melinda.develey70@yahoo.com>
Subject: Re: spin_lock doesn't work?!?
To: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
In-Reply-To: <20070829214050.8C47A1A2804D@mail19-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-135001011-1188455422=:1267"
Message-ID: <762949.1267.qm@web63906.mail.re1.yahoo.com>
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

--0-135001011-1188455422=:1267
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

  >You should still put the spin_lock calls into your code because >you
>never know if someone else will compile it and for another >target. If
>someone would, for example, compile the same code for a SMP >machine then
>the spin_lock will actually lock.

  I used the spinlock both in an interrupt handler to protect a group of variables (because in an interrupt I can't use a semaphore) and the same spinlock in a ioctl handler where the same group of variables is accessed. Is this wrong? I have a 2.6.19.2 linux kernel.
   
  Thank you,
  Melinda.
   
   
   

       
---------------------------------
Ready for the edge of your seat? Check out tonight's top picks on Yahoo! TV. 
--0-135001011-1188455422=:1267
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">  <div>&gt;You should still put the spin_lock calls into your code because &gt;you<BR>&gt;never know if someone else will compile it and for another &gt;target. If<BR>&gt;someone would, for example, compile the same code for a SMP &gt;machine then<BR>&gt;the spin_lock will actually lock.<BR></div>  <div>I used the spinlock both in an interrupt handler to protect a group of variables (because in an interrupt I can't use a semaphore) and the same spinlock in a ioctl handler where the same group of variables is accessed. Is this wrong? I have a 2.6.19.2 linux kernel.</div>  <div>&nbsp;</div>  <div>Thank you,</div>  <div>Melinda.</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>&nbsp;</div></BLOCKQUOTE><p>&#32;
      <hr size=1>Ready for the edge of your seat? 
<a href="http://us.rd.yahoo.com/evt=48220/*http://tv.yahoo.com/">Check out tonight's top picks</a> on Yahoo! TV. 


--0-135001011-1188455422=:1267--
