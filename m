Return-Path: <oliver8849@yahoo.com>
Received: from web53808.mail.re2.yahoo.com (web53808.mail.re2.yahoo.com
	[206.190.36.203]) by ozlabs.org (Postfix) with SMTP id BAE98DDFC5
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 01:07:41 +1000 (EST)
Date: Thu, 11 Oct 2007 08:00:15 -0700 (PDT)
From: Oliver Liu <oliver8849@yahoo.com>
Subject: Warning: "isa_io_base" [/home/oliu/pmm-mpc-k26-6437/pmm.ko] undefined!
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-486800107-1192114815=:72998"
Message-ID: <4613.72998.qm@web53808.mail.re2.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-486800107-1192114815=:72998
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  When i compile my device driver for kernel2.6, i got a warning as followng:
  Warning: "isa_io_base" [/home/oliu/pmm-mpc-k26-6437/pmm.ko] undefined! 
   
  When i insmod pmm.ko, i got the message as following:
  # insmod pmm.ko
pmm: Unknown symbol isa_io_base
insmod: cannot insert `pmm.ko': Unknown symbol in module (-1): No such file or directory
# 
   
  I am sure the symbol "isa_io_base" is not come from my driver source code. Has anybody  ever met this problem before?
   
  Regards,
  Oliver

       
---------------------------------
Be a better Heartthrob. Get better relationship answers from someone who knows.
Yahoo! Answers - Check it out. 
--0-486800107-1192114815=:72998
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>When&nbsp;i compile my device driver for kernel2.6,&nbsp;i got a warning as followng:</div>  <div><STRONG>Warning: "isa_io_base" [/home/oliu/pmm-mpc-k26-6437/pmm.ko] undefined!</STRONG> </div>  <div>&nbsp;</div>  <div>When i insmod pmm.ko, i got the message as following:</div>  <div># insmod pmm.ko<BR><STRONG>pmm: Unknown symbol isa_io_base<BR>insmod: cannot insert `pmm.ko': Unknown symbol in module (-1): No such file or directory</STRONG><BR># </div>  <div>&nbsp;</div>  <div>I am sure the symbol "isa_io_base" is not come from my driver source code. Has anybody&nbsp; ever met this problem before?</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Oliver</div><p>&#32;
      <hr size=1>Be a better Heartthrob. <a href="http://us.rd.yahoo.com/evt=48255/*http://answers.yahoo.com/dir/_ylc=X3oDMTI5MGx2aThyBF9TAzIxMTU1MDAzNTIEX3MDMzk2NTQ1MTAzBHNlYwNCQUJwaWxsYXJfTklfMzYwBHNsawNQcm9kdWN0X3F1ZXN0aW9uX3BhZ2U-?link=list&sid=396545433">Get better relationship answers </a>from someone who knows.<br>Yahoo! Answers - Check it out. 

--0-486800107-1192114815=:72998--
