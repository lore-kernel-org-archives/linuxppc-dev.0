Return-Path: <johnzhouzj@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by ozlabs.org (Postfix) with ESMTP id B3648DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 May 2008 11:14:51 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so2792940tib.13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 18:14:50 -0700 (PDT)
Message-ID: <966933c00805291814s12439a96q57fabe77ff1139ec@mail.gmail.com>
Date: Fri, 30 May 2008 09:14:50 +0800
From: "John Zhou" <johnzhouzj@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Question on PowerPC's JTAG instruction
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5300_13445732.1212110090279"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_5300_13445732.1212110090279
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

We want to design a tool to speed up our hardware diagnostics via JTAG
port.

So we have question to ask for your help:

1. How do we access PowerPC's internal GPRs and SPRs etc. via JTAG
instruction?

We'v gone through IEEE.1149.1.   There are no standard JTAG instruction to
access CPU's data bus, including internal or external data bus. Do we must
need private JTAG instruction to access CPU's internal resource? if it is,
could you share the documents with us?

2. For 'BSDL' usage, you know, we have many components on one board and much
more signals are processed specically. So, how to integrate PowerPC's BSDL
with other components' 'BSDL'?  Could you give us any hints on it? or any
document is also welcome!

Your any help is appreciated!

John Zhou

------=_Part_5300_13445732.1212110090279
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008"><br>We want to design a tool to speed up our hardware 
diagnostics via JTAG port.&nbsp; </span></font></font></font></div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008"></span></font></font></font>&nbsp;</div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008">So w<span class="937200610-29052008">e have question to 
ask for your help:</span></span></font></font></font></div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008"></span></font></font></font>&nbsp;</div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008">1. How do we access PowerPC&#39;s internal GPRs and SPRs 
etc. via JTAG instruction?&nbsp; </span></font></font></font></div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008"></span></font></font></font>&nbsp;</div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008">We&#39;v gone through IEEE.1149.1.&nbsp;&nbsp; There are no&nbsp;standard 
JTAG instruction to access&nbsp;CPU&#39;s data bus, including internal or external data 
bus. Do we must need private JTAG instruction to access CPU&#39;s internal resource? 
if it is, could you&nbsp;share&nbsp;the documents&nbsp;with 
us?</span></font></font></font></div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008"></span></font></font></font>&nbsp;</div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008">2. For &#39;BSDL&#39; usage, you know, we have many components 
on one board and much more signals are processed specically. So, how to 
integrate PowerPC&#39;s BSDL with other components&#39; &#39;BSDL&#39;?&nbsp; Could you give us any 
hints on it? or any document is also welcome!</span></font></font></font></div>
<div dir="ltr" align="left"><font face="Arial"><font color="#0000ff"><font size="2"><span class="937200610-29052008"></span></font></font></font>&nbsp;</div>
<div dir="ltr" align="left"><font color="#0000ff" face="Arial" size="2">Your any help is 
appreciated!<br><br></font></div><font color="#0000ff"><font size="2"><font face="Arial">John Zhou<br></font></font></font><div dir="ltr" align="left"><font color="#0000ff" face="Arial" size="2"><span class="937200610-29052008"></span></font> <br>
</div><br>

------=_Part_5300_13445732.1212110090279--
