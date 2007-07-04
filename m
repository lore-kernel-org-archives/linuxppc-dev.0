Return-Path: <li.chunlin@zte.com.cn>
Received: from mx4.zte.com.cn (unknown [202.103.147.155])
	by ozlabs.org (Postfix) with ESMTP id 4346ADDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 16:56:17 +1000 (EST)
In-Reply-To: <8496f91a0707032242w40c0f398s87ab5a9249c0e902@mail.gmail.com>
To: matvejchikov@gmail.com
Subject: Re: about FCC of MPC8270
MIME-Version: 1.0
Message-ID: <OF0D7C4044.9BAD3D4B-ON4825730E.0025DB9D-4825730E.002615DC@zte.com.cn>
From: li.chunlin@zte.com.cn
Date: Wed, 4 Jul 2007 14:55:21 +0800
Content-Type: multipart/alternative;
	boundary="=_alternative 002615DB4825730E_="
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

This is a multipart message in MIME format.
--=_alternative 002615DB4825730E_=
Content-Type: text/plain; charset="US-ASCII"

I use it. And it is: #define CPM_FCC_SPECIAL_BASE       ((uint)0x0000b000)



Hi!

Do you use CPM_FCC_SPECIAL_BASE constant? (include/asm-ppc/cpm2.h)
In my case (8250, 8260) FCCs only works when it is set to 0x3000...


2007/7/4, li.chunlin@zte.com.cn <li.chunlin@zte.com.cn>:
>
> hello, every one
>
>    I have a board with mpc8270. And there are two ethernet interface by 
fcc1
> and fcc2. Now in linux kernel 2.6.14 fcc1 is ok, but fcc2 is some wrong. 
I
> set loopback of fcc2 or rmii. that's ok. But i set loopback in phy, it 
is
> wrong. But fcc2 is ok in u-boot.
>
> I take a look with oscillograph. i find that there is signal from fcc2 
to
> phy and there is signal from phy to fcc2 in data pins. But fcc2 cannot
> receive data and fcc2 can send data.
>
> who know the reason? Can you tell me?
>
> thanks.
> lichunlin
>




--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail is solely property of the sender's organization. This mail communication is confidential. Recipients named above are obligated to maintain secrecy and are not permitted to disclose the contents of this communication to others.
This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the originator of the message. Any views expressed in this message are those of the individual sender.
This message has been scanned for viruses and Spam by ZTE Anti-Spam system.

--=_alternative 002615DB4825730E_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">I use it. And it is: #define CPM_FCC_SPECIAL_BASE
&nbsp; &nbsp; &nbsp; &nbsp;((uint)0x0000b000)</font>
<br>
<br>
<br>
<br><font size=2><tt>Hi!<br>
<br>
Do you use CPM_FCC_SPECIAL_BASE constant? (include/asm-ppc/cpm2.h)<br>
In my case (8250, 8260) FCCs only works when it is set to 0x3000...<br>
<br>
<br>
2007/7/4, li.chunlin@zte.com.cn &lt;li.chunlin@zte.com.cn&gt;:<br>
&gt;<br>
&gt; hello, every one<br>
&gt;<br>
&gt; &nbsp; &nbsp;I have a board with mpc8270. And there are two ethernet
interface by fcc1<br>
&gt; and fcc2. Now in linux kernel 2.6.14 fcc1 is ok, but fcc2 is some
wrong. I<br>
&gt; set loopback of fcc2 or rmii. that's ok. But i set loopback in phy,
it is<br>
&gt; wrong. But fcc2 is ok in u-boot.<br>
&gt;<br>
&gt; I take a look with oscillograph. i find that there is signal from
fcc2 to<br>
&gt; phy and there is signal from phy to fcc2 in data pins. But fcc2 cannot<br>
&gt; receive data and fcc2 can send data.<br>
&gt;<br>
&gt; who know the reason? Can you tell me?<br>
&gt;<br>
&gt; thanks.<br>
&gt; lichunlin<br>
&gt;<br>
<br>
</tt></font>
<br><br><pre>
--------------------------------------------------------
ZTE&nbsp;Information&nbsp;Security&nbsp;Notice:&nbsp;The&nbsp;information&nbsp;contained&nbsp;in&nbsp;this&nbsp;mail&nbsp;is&nbsp;solely&nbsp;property&nbsp;of&nbsp;the&nbsp;sender's&nbsp;organization.&nbsp;This&nbsp;mail&nbsp;communication&nbsp;is&nbsp;confidential.&nbsp;Recipients&nbsp;named&nbsp;above&nbsp;are&nbsp;obligated&nbsp;to&nbsp;maintain&nbsp;secrecy&nbsp;and&nbsp;are&nbsp;not&nbsp;permitted&nbsp;to&nbsp;disclose&nbsp;the&nbsp;contents&nbsp;of&nbsp;this&nbsp;communication&nbsp;to&nbsp;others.
This&nbsp;email&nbsp;and&nbsp;any&nbsp;files&nbsp;transmitted&nbsp;with&nbsp;it&nbsp;are&nbsp;confidential&nbsp;and&nbsp;intended&nbsp;solely&nbsp;for&nbsp;the&nbsp;use&nbsp;of&nbsp;the&nbsp;individual&nbsp;or&nbsp;entity&nbsp;to&nbsp;whom&nbsp;they&nbsp;are&nbsp;addressed.&nbsp;If&nbsp;you&nbsp;have&nbsp;received&nbsp;this&nbsp;email&nbsp;in&nbsp;error&nbsp;please&nbsp;notify&nbsp;the&nbsp;originator&nbsp;of&nbsp;the&nbsp;message.&nbsp;Any&nbsp;views&nbsp;expressed&nbsp;in&nbsp;this&nbsp;message&nbsp;are&nbsp;those&nbsp;of&nbsp;the&nbsp;individual&nbsp;sender.
This&nbsp;message&nbsp;has&nbsp;been&nbsp;scanned&nbsp;for&nbsp;viruses&nbsp;and&nbsp;Spam&nbsp;by&nbsp;ZTE&nbsp;Anti-Spam&nbsp;system.
</pre>
--=_alternative 002615DB4825730E_=--
