Return-Path: <Peter.Ryser@xilinx.com>
Received: from mail44-R-kan.bigfish.com (mail-kan.bigfish.com [63.161.60.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 87DA82BD46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 02:56:07 +1000 (EST)
Date: Tue, 26 Oct 2004 09:55:33 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
In-reply-to: <35fb2e5904102608487acce066@mail.gmail.com>
To: jonathan@jonmasters.org
Message-id: <417E8185.6020004@xilinx.com>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="Boundary_(ID_rcXPVfW946bQ/jeAcK6ruw)"
References: <1098701468l.31592l.0l@ipnnarval> <417D2B5E.8050200@xilinx.com>
	<35fb2e59041025140776cfe174@mail.gmail.com>
	<417DE312.6070405@xilinx.com>
	<35fb2e5904102608487acce066@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: uboot and ppc405
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

--Boundary_(ID_rcXPVfW946bQ/jeAcK6ruw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


>I have every confidence that it works on the ML300, just not on other
>boards, including both the Memec board and our in house prototypes.
>
My web and mail server runs on a Memec board. I've seen our and customer 
boards up and running for extended periods of time without any problems 
with regard to System ACE CF.

>>There is now a MVL preview kit for the Memec board. You might want to
>>try it out and see whether the problems you observe persist.
>>    
>>
>
>Is this the one which doesn't actually use the SystemACE for a filesystem?
>
System ACE CF can be turned on in the kernel configuration. Making a 
root filesystem on the CF or MD is straight forward.

>>Looking at the postings back in April I can only say that I never saw
>>any similar problems.
>>    
>>
>
>Others have done so. I'll check with the hardware guys and see if I
>can't send you a simple hardware case that falls over at some point -
>I'm slightly constrained to release hardware designs and so on until
>after this thing is ready to ship.
>
Ok, that's a plan. When you are ready please file a web case and mention 
my name so that the problem resolution gets tracked properly.

- Peter


--Boundary_(ID_rcXPVfW946bQ/jeAcK6ruw)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: 7BIT

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<br>
<blockquote type="cite"
 cite="mid35fb2e5904102608487acce066@mail.gmail.com">
  <pre wrap="">I have every confidence that it works on the ML300, just not on other
boards, including both the Memec board and our in house prototypes.</pre>
</blockquote>
My web and mail server runs on a Memec board. I've seen our and
customer boards up and running for extended periods of time without any
problems with regard to System ACE CF.<br>
<blockquote type="cite"
 cite="mid35fb2e5904102608487acce066@mail.gmail.com">
  <blockquote type="cite">
    <pre wrap="">There is now a MVL preview kit for the Memec board. You might want to
try it out and see whether the problems you observe persist.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Is this the one which doesn't actually use the SystemACE for a filesystem?</pre>
</blockquote>
System ACE CF can be turned on in the kernel configuration. Making a
root filesystem on the CF or MD is straight forward.<br>
<blockquote type="cite"
 cite="mid35fb2e5904102608487acce066@mail.gmail.com">
  <blockquote type="cite">
    <pre wrap="">Looking at the postings back in April I can only say that I never saw
any similar problems.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Others have done so. I'll check with the hardware guys and see if I
can't send you a simple hardware case that falls over at some point -
I'm slightly constrained to release hardware designs and so on until
after this thing is ready to ship.</pre>
</blockquote>
Ok, that's a plan. When you are ready please file a web case and
mention my name so that the problem resolution gets tracked properly.<br>
<br>
- Peter<br>
<br>
</body>
</html>

--Boundary_(ID_rcXPVfW946bQ/jeAcK6ruw)--
