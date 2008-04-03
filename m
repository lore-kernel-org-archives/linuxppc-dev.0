Return-Path: <lmejjad@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by ozlabs.org (Postfix) with ESMTP id A3161DE0E7
	for <linuxppc-embedded@ozlabs.org.>;
	Fri,  4 Apr 2008 01:04:16 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so4902775mue.1
	for <linuxppc-embedded@ozlabs.org.>;
	Thu, 03 Apr 2008 07:04:13 -0700 (PDT)
Message-ID: <9b4863980804030704t4f6c7d54xe2085a132a20ee73@mail.gmail.com>
Date: Thu, 3 Apr 2008 10:04:12 -0400
From: "mejjad lahcen" <lmejjad@gmail.com>
To: linuxppc-embedded@ozlabs.org.
Subject: interrupt latency spi
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_909_10772471.1207231452327"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_909_10772471.1207231452327
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all of you , I am wndering if someone has already done test for interrupt
latency on  linx 2.6.23 mpc5200b.
I am working on writing a driver which is get SPi involved on design, and I
know that the  spi interrupt will occurs at every 2 us ( speed 4 MHz
interupt occurs when It recieves on bytes) so  I am worring about interrupt
latency.
 I dont know if someone has any suggestions or a litle advice.
cheers

------=_Part_909_10772471.1207231452327
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all of you , 
<div>I am wndering if someone has already done test for interrupt latency on&nbsp; linx 2.6.23 mpc5200b.</div>
<div>I am working on writing a driver which is get SPi involved on design, and I know that the&nbsp; spi interrupt will occurs at every 2 us ( speed 4 MHz interupt occurs when It recieves on bytes) so&nbsp; I am worring about interrupt latency.</div>

<div>&nbsp;I dont know if someone has any suggestions&nbsp;or a litle advice.</div>
<div>cheers</div>

------=_Part_909_10772471.1207231452327--
