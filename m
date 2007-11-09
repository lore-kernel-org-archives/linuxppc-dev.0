Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 1497FDDEDA
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 05:46:28 +1100 (EST)
Message-ID: <4734AAFC.8080907@harris.com>
Date: Fri, 09 Nov 2007 13:46:20 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: PPC440EPx on Sequoia: /proc/iomem acts weird
References: <4734A72B.2070104@harris.com> <20071109123522.072bc1d8@weaponx>
In-Reply-To: <20071109123522.072bc1d8@weaponx>
Content-Type: multipart/alternative;
	boundary="------------060007080804050701080105"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060007080804050701080105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am using the Denx 2.6.32 kernel, which does have powerpc/sequoia.  
Xenomai is a real-time kernel built on Adeos/Ipipe.  I'll dig into it 
further.

    Steve


Josh Boyer wrote:
> On Fri, 09 Nov 2007 13:30:03 -0500
> "Steven A. Falco" <sfalco@harris.com> wrote:
>
>   
>> If I cat /proc/iomem on a Sequoia board, it never stops printing.  Here 
>> are the first 10 lines:
>>
>> bash-3.00# head -10 /proc/iomem
>> e0000100-e000017f : usb
>>   e0000100-e000017f : musbhsfc_udc
>> e0000300-e000038f : ehci_hcd
>> 180000000-18fffffff : /plb/pci@1eec00000
>>           1d0000000-1d0001fff : ndfc
>>           1d0000000-1d0001fff : ndfc
>>           1d0000000-1d0001fff : ndfc
>>           1d0000000-1d0001fff : ndfc
>>           1d0000000-1d0001fff : ndfc
>>           1d0000000-1d0001fff : ndfc
>>
>> Basically, the last line (regarding the nand flash) keeps repeating 
>> "forever".
>>
>> Is anyone else seeing this behavior?  My kernel is 2.6.23 with Xenomai 
>> patched in.
>>     
>
> Erm.. 2.6.23?  There is no Sequoia support in arch/ppc or arch/powerpc
> for 2.6.23 in the official trees.  What is Xenomai?  You should
> probably talk to them.
>
> josh
>
>   

--------------060007080804050701080105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>I am using the Denx 2.6.32 kernel, which does have
powerpc/sequoia.&nbsp; Xenomai is a real-time kernel built on Adeos/Ipipe.&nbsp;
I'll dig into it further.<br>
<br>
&nbsp;&nbsp;&nbsp; Steve<br>
<br>
</tt><br>
Josh Boyer wrote:
<blockquote cite="mid:20071109123522.072bc1d8@weaponx" type="cite">
  <pre wrap="">On Fri, 09 Nov 2007 13:30:03 -0500
"Steven A. Falco" <a class="moz-txt-link-rfc2396E" href="mailto:sfalco@harris.com">&lt;sfalco@harris.com&gt;</a> wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">If I cat /proc/iomem on a Sequoia board, it never stops printing.  Here 
are the first 10 lines:

bash-3.00# head -10 /proc/iomem
e0000100-e000017f : usb
  e0000100-e000017f : musbhsfc_udc
e0000300-e000038f : ehci_hcd
180000000-18fffffff : /plb/pci@1eec00000
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc

Basically, the last line (regarding the nand flash) keeps repeating 
"forever".

Is anyone else seeing this behavior?  My kernel is 2.6.23 with Xenomai 
patched in.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Erm.. 2.6.23?  There is no Sequoia support in arch/ppc or arch/powerpc
for 2.6.23 in the official trees.  What is Xenomai?  You should
probably talk to them.

josh

  </pre>
</blockquote>
</body>
</html>

--------------060007080804050701080105--
