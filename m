Return-Path: <Peter.Ryser@xilinx.com>
Date: Thu, 03 Mar 2005 08:00:16 -0800
From: Peter Ryser <Peter.Ryser@xilinx.com>
In-reply-to: <20050303085616.34381.qmail@web51404.mail.yahoo.com>
To: T T <tath76@yahoo.com>
Message-id: <42273490.1040404@xilinx.com>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="Boundary_(ID_FU8MAXTemIMlJP4cVyj5OA)"
References: <20050303085616.34381.qmail@web51404.mail.yahoo.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: linux on xc2vp4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Boundary_(ID_FU8MAXTemIMlJP4cVyj5OA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Have a look at http://direct.xilinx.com/bvdocs/appnotes/xapp765.pdf. 
This should get you started. Instead of targetting the ML300 board in 
the Base System Builder create a system for a customer board. Don't 
forget to modify the UCF file to constrain the pinout.

All the peripherals you mention are supported in the PowerPC Linux 
kernel tree for Virtex-II Pro FPGAs.

- Peter


T T wrote:

> Hi all,
>  
> I would like to port linux kernel to a custom board that contains 
> xc2vp4 (xilinx fpga) which it include powerpc 405 hard core, uartlite, 
> spi controller, sdram controller.  I don't how to start because I am 
> new to linux os.  Any help is welcome.
>  
> Thanks.
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam? Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

--Boundary_(ID_FU8MAXTemIMlJP4cVyj5OA)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: 7BIT

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Have a look at <a class="moz-txt-link-freetext" href="http://direct.xilinx.com/bvdocs/appnotes/xapp765.pdf">http://direct.xilinx.com/bvdocs/appnotes/xapp765.pdf</a>.
This should get you started. Instead of targetting the ML300 board in
the Base System Builder create a system for a customer board. Don't
forget to modify the UCF file to constrain the pinout.<br>
<br>
All the peripherals you mention are supported in the PowerPC Linux
kernel tree for Virtex-II Pro FPGAs.<br>
<br>
- Peter<br>
<br>
<br>
T T wrote:<br>
<blockquote type="cite"
 cite="mid20050303085616.34381.qmail@web51404.mail.yahoo.com">
  <div>Hi all,</div>
  <div>&nbsp;</div>
  <div>I would like to port linux kernel to a custom board that
contains xc2vp4 (xilinx fpga) which it include powerpc 405 hard core,
uartlite, spi controller, sdram controller.&nbsp; I don't how to start
because I am new to linux os.&nbsp; Any help is welcome.</div>
  <div>&nbsp;</div>
  <div>Thanks.</div>
  <p>__________________________________________________<br>
Do You Yahoo!?<br>
Tired of spam? Yahoo! Mail has the best spam protection around <br>
<a class="moz-txt-link-freetext" href="http://mail.yahoo.com">http://mail.yahoo.com</a> </p>
  <pre wrap="">
<hr width="90%" size="4">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
</body>
</html>

--Boundary_(ID_FU8MAXTemIMlJP4cVyj5OA)--
