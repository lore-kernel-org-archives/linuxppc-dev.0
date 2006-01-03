Return-Path: <andreas_schmidt@ifm-electronic.com>
Received: from mail1.ifm-electronic.com (mail1.ifm-electronic.com
	[62.180.229.59]) by ozlabs.org (Postfix) with ESMTP id 30ACF688F3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jan 2006 23:36:36 +1100 (EST)
In-Reply-To: <43B9F69B.6090407@secretlab.ca>
To: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
Message-ID: <OF6AA099E7.718620CD-ONC12570EB.0042FAA2-C12570EB.004384F8@ifm-electronic.com>
From: andreas_schmidt@ifm-electronic.com
Date: Tue, 3 Jan 2006 13:16:23 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 004384F5C12570EB_="
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Re: Custom Driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dies ist eine mehrteilige Nachricht im MIME-Format.
--=_alternative 004384F5C12570EB_=
Content-Type: text/plain; charset="US-ASCII"

>Brett McNerney wrote:
>> I am need to create a driver to interface to custom hardware on a ml403
>> board.  I am first trying to just create a ipif register bank and 
access
>> the registers from linux but am not having any luck of yet.  Has anyone
>> successfully done this and if so explain how or supply a driver to do
>> this and how to build it into the kernel?  I am new at this and am
>> having great difficutly right now. 
>> 
>> Thanks for any help anyone can supply
>Can you access your device from a debugger, or a no-os program (like a
>bootloader)?  Did you call ioremap() to map the physical register
>address into virtual memory?  Can you give more detail?

I have already wrote I custom driver for Xilinx FPGA. 
For this I have looked to already exist driver for Xilinx in Linux tree 
and modify them for me.
It was no problem then.

g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
--=_alternative 004384F5C12570EB_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><font size=2><tt>&gt;Brett McNerney wrote:<br>
&gt;&gt; I am need to create a driver to interface to custom hardware on
a ml403<br>
&gt;&gt; board. &nbsp;I am first trying to just create a ipif register
bank and access<br>
&gt;&gt; the registers from linux but am not having any luck of yet. &nbsp;Has
anyone<br>
&gt;&gt; successfully done this and if so explain how or supply a driver
to do<br>
&gt;&gt; this and how to build it into the kernel? &nbsp;I am new at this
and am<br>
&gt;&gt; having great difficutly right now. <br>
&gt;&gt; <br>
&gt;&gt; Thanks for any help anyone can supply<br>
&gt;Can you access your device from a debugger, or a no-os program (like
a<br>
&gt;bootloader)? &nbsp;Did you call ioremap() to map the physical register<br>
&gt;address into virtual memory? &nbsp;Can you give more detail?</tt></font>
<br>
<br><font size=2><tt>I have already wrote I custom driver for Xilinx FPGA.
</tt></font>
<br><font size=2><tt>For this I have looked to already exist driver for
Xilinx in Linux tree and modify them for me.<br>
It was no problem then.</tt></font>
<br><font size=2><tt><br>
g.<br>
<br>
<br>
-- <br>
Grant Likely, B.Sc. P.Eng.<br>
Secret Lab Technologies Ltd.<br>
(403) 663-0761</tt></font>
--=_alternative 004384F5C12570EB_=--
