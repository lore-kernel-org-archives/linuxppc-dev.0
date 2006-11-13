Return-Path: <bharthik2004@yahoo.com>
Received: from web50805.mail.yahoo.com (web50805.mail.yahoo.com
	[206.190.38.114]) by ozlabs.org (Postfix) with SMTP id 8F55867D4E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Nov 2006 17:20:37 +1100 (EST)
Date: Sun, 12 Nov 2006 22:20:35 -0800 (PST)
From: bharathi kandimalla <bharthik2004@yahoo.com>
Subject: TLB LOCKING 
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2115377397-1163398835=:26310"
Message-ID: <314783.26310.qm@web50805.mail.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2115377397-1163398835=:26310
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 Hi
  I came to know, with the MMU always being enabled
  it is not possible for the processor to access instructions and data
  using a physical addressing during excetion processing
   
  1.Now I want to lock some I/o memory.? (loading locked TLB  ENTRIES) after MMu_init
    How to do it in the kernel?
  
  2. Is it possible to completely disable the MMU for MPC860T IN LINUX 2.4.20
   and  use it for custom board
  
   thanks
   bharathi
  

 
---------------------------------
Everyone is raving about the all-new Yahoo! Mail beta.
--0-2115377397-1163398835=:26310
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>&nbsp;Hi<BR>&nbsp; I came to know, with the MMU always being enabled<BR>&nbsp; it is not possible for the processor to access instructions and data<BR>&nbsp; using a physical addressing during excetion processing</div>  <div>&nbsp;<BR>&nbsp; 1.Now I want to lock some I/o memory.? (loading locked TLB&nbsp; ENTRIES) after MMu_init</div>  <div>&nbsp; How to do it in the kernel?</div>  <div><BR>&nbsp; 2. Is it possible to completely disable the MMU for MPC860T IN LINUX 2.4.20<BR>&nbsp;&nbsp; and&nbsp; use it for custom board</div>  <div><BR>&nbsp;&nbsp; thanks<BR>&nbsp;&nbsp; bharathi<BR>&nbsp; </div><p>&#32;


<hr size=1>Everyone is raving about <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta.</a>
--0-2115377397-1163398835=:26310--
