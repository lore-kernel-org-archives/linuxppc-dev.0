Return-Path: <jiehanca@yahoo.com.cn>
Received: from web15102.mail.cnb.yahoo.com (web15102.mail.cnb.yahoo.com
	[202.165.103.71]) by ozlabs.org (Postfix) with SMTP id 1F90BDDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 11:11:37 +1100 (EST)
Date: Tue, 29 Jan 2008 16:11:35 -0800 (PST)
From: jie han <jiehanca@yahoo.com.cn>
Subject: Help: I will port amcc yucca board to denx kernel ARCH=powepc
	directory.How to config dts file?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-314876389-1201651895=:20606"
Message-ID: <593873.20606.qm@web15102.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-314876389-1201651895=:20606
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,
I want to port amcc yucca board denx linux kernel from ARCH=ppc to ARCH=powerpc. I used sequoia.dts for yucca baord demo device tree file.
I set uart0 as follow:
            UART0: serial@f0000200 {
                   device_type = "serial";
                   compatible = "ns16550";
                   reg = <f0000200 8>;
                   virtual-reg = <f0000200>;
                   clock-frequency = <0>; /* Filled in by zImage */
                   current-speed = <1c200>;
                   interrupt-parent = <&UIC0>;
                   interrupts = <0 4>;
               };

    chosen {
        linux,stdout-path = "/plb/opb/serial@f0000300";
        bootargs = "console=ttyS0,115200";
    };

the other parts of dts file is same as sequoia.dts.
When I run kernel.the tlb entry setup is wrong,the physical addres should be 4f0000200,but kernel calcuate is 1f0000200.I know yucca dts file isn't right.how can I fix it?Give me some advices,Thanks ahead,

Sincerely,

Jie



       
---------------------------------
Be a better friend, newshound, and know-it-all with Yahoo! Mobile.  Try it now.
--0-314876389-1201651895=:20606
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,<br>I want to port amcc yucca board denx linux kernel from ARCH=ppc to ARCH=powerpc. I used sequoia.dts for yucca baord demo device tree file.<br>I set uart0 as follow:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UART0: serial@f0000200 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = "serial";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = "ns16550";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;f0000200 8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; virtual-reg = &lt;f0000200&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency = &lt;0&gt;; /* Filled in by zImage */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; current-speed
 = &lt;1c200&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;UIC0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;0 4&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; chosen {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; linux,stdout-path = "/plb/opb/serial@f0000300";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bootargs = "console=ttyS0,115200";<br>&nbsp;&nbsp;&nbsp; };<br><br>the other parts of dts file is same as sequoia.dts.<br>When I run kernel.the tlb entry setup is wrong,the physical addres should be 4f0000200,but kernel calcuate is 1f0000200.I know yucca dts file isn't right.how can I fix it?Give me some advices,Thanks ahead,<br><br>Sincerely,<br><br>Jie<br><br><br><p>&#32;
      <hr size=1>Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile. <a href="http://us.rd.yahoo.com/evt=51733/*http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ "> Try it now.</a>
--0-314876389-1201651895=:20606--
